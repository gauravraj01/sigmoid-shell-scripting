#!/bin/bash

cat /home/sigmoid/shell-scripting-assignment/sig.conf
echo
echo
echo  "select component name"
 select COMPONENT_NAME in INGESTOR JOINER WRANGLER VALIDATOR
do
    case $COMPONENT_NAME in 
    INGESTOR)
        echo INGESTOR selected
        ;;
    JOINER)
        echo JOINER selected
        ;;
    WRANGLER)
        echo WRANGLER selected
        ;;
    VALIDATOR)
        echo VALIDATOR selected
        ;;
    *)
        echo "Error please provide the number between 1..4"
    esac
    break
done

echo
echo  "select view"
select VIEW in AUCTION BID
do
    case $VIEW in
    AUCTION)
        echo AUCTION selected
        ;;
    BID)
        echo BID selected
        ;;
    *)
    echo "Error please provide the number between 1..4"
    esac
    break
done

echo
echo  "scale"
select SCALE in MID HIGH LOW
do
    case $SCALE in
    MID)
        echo MID selected
        ;;
    HIGH)
        echo HIGH selected
        ;;
    LOW)
        echo LOW selected
        ;;
    *)
    echo "Error please provide the number between 1..4"
    esac
    break
done

echo
echo  "select count from 1 to 9"
select COUNT in 1 2 3 4 5 6 7 8 9
do
    if [ $COUNT -gt 0 ] || [ $COUNT -ge 9 ]
    then
        echo COUNT selected
    else
    echo "INVALID COUNT"
    fi
break
done

if [ "$VIEW" == "AUCTION" ]
then
    LINE=$(cat /home/sigmoid/shell-scripting-assignment/sig.conf | grep -n -v "vdopiasample-bid" | grep "$COMPONENT_NAME" | awk -F ':' '{print $1}' )
    INITIAL_SCALE=$(cat /home/sigmoid/shell-scripting-assignment/sig.conf | grep -v "vdopiasample-bid" | grep "$COMPONENT_NAME" | awk -F ';' '{print $2}' )
    INITIAL_COUNT=$(cat /home/sigmoid/shell-scripting-assignment/sig.conf | grep -v "vdopiasample-bid" | grep "$COMPONENT_NAME" | awk -F '=' '{print $2}' )
    echo "$LINE"
    echo "$INITIAL_SCALE"
    echo "$INITIAL_COUNT"
    echo "$COUNT"
    echo "$SCALE"
    sed  -i "${LINE}s/${INITIAL_SCALE}/${SCALE}/" /home/sigmoid/shell-scripting-assignment/sig.conf
    sed  -i "${LINE}s/${INITIAL_COUNT}/${COUNT}/" /home/sigmoid/shell-scripting-assignment/sig.conf
    
    echo "value updated"
    

elif [ "$VIEW" == "BID" ]
then
    LINE=$(cat /home/sigmoid/shell-scripting-assignment/sig.conf | grep -n "vdopiasample-bid" | grep "$COMPONENT_NAME" | awk -F ':' '{print $1}' )
    INITIAL_SCALE=$(cat /home/sigmoid/shell-scripting-assignment/sig.conf | grep "vdopiasample-bid" | grep "$COMPONENT_NAME" | awk -F ';' '{print $2}' )
    INITIAL_COUNT=$(cat /home/sigmoid/shell-scripting-assignment/sig.conf | grep "vdopiasample-bid" | grep "$COMPONENT_NAME" | awk -F '=' '{print $2}' )
    echo "$LINE"
    echo "$INITIAL_SCALE"
    echo "$INITIAL_COUNT"
    echo "$COUNT"
    echo "$SCALE"
        sed  -i "${LINE}s/${INITIAL_SCALE}/${SCALE}/" /home/sigmoid/shell-scripting-assignment/sig.conf
        sed  -i "${LINE}s/${INITIAL_COUNT}/${COUNT}/" /home/sigmoid/shell-scripting-assignment/sig.conf
    
    echo "value updated"
    
else
    echo "ENTER VALID INPUT"
fi
