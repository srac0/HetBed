#! /bin/bash

# run kill command every KILL_TIME seconds
KILL_TIME="1m 1s"

while true; do 
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-01
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-02
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-03
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-04
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-05
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-06
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-07
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-08
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-09
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-10
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-11
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-12
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-13
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-14
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-15
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-16
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-17
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-18
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-19
  kubectl delete pods -n f5gc --force -l app=f5gc-ue-pool-20
  sleep $KILL_TIME
done
