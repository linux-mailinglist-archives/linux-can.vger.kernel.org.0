Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381AE3FAB12
	for <lists+linux-can@lfdr.de>; Sun, 29 Aug 2021 13:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhH2LVz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 29 Aug 2021 07:21:55 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:35906 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhH2LVz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 29 Aug 2021 07:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1630235881;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=zqs6o0lmE1KrWwqmqeM8BZTY9UNJICybUvn5Y6tw6fI=;
    b=oaA3uaKhgA9CVixLrNRAJFC73MAyW6sbFQWEOAgjrJ1bxY4WrwlPtpZ2tWoKcD5R6p
    BpUFPhAjB28Ngyr4b5G58q4xvzo6GgEWgizQxpZ076fwxp8yljHg2MTN6dtbG9TfpMtu
    6YewO6aZbEpHZRSR02rQRN67Hlwpp1vzXPdbN/ujbnPXtBxbI4p1QAwsB8y/GOR5UOBd
    yN40qtxTb9LHuwQJuuuwk4hlMYYPJqgjhD7XMt0IzaTbdclXZtU4iEDDrTTA2+4S8u2v
    e3XApnWvTw5NLL3gqyBNqDxd4rzeJSspkKt6QuqFqNgiwKflSEhoSp/L+KhN8R+6jZtX
    bClQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR8J8xryV0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.31]
    by smtp.strato.de (RZmta 47.31.0 DYNA|AUTH)
    with ESMTPSA id Q09fd7x7TBI0xZb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 29 Aug 2021 13:18:00 +0200 (CEST)
Subject: Re: AW: [PATCH] can: isotp: omit unintended hrtimer restart on socket
 release
To:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <20210618173713.2296-1-socketcan@hartkopp.net>
 <DB8P190MB06343614CAD6B48C3EA0EF00D9C99@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <abc23fd0-9bb1-1cc7-fc67-0a3298673b86@hartkopp.net>
Date:   Sun, 29 Aug 2021 13:17:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <DB8P190MB06343614CAD6B48C3EA0EF00D9C99@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Sven,

On 28.08.21 15:20, Sven Schuchmann wrote:

> sorry, I'm late for the party :-)

NP ;-)

> But I found that this patch decreases the performance of ISO-TP Stack.

AFAICS the performance (aka throughput) of the ISO-TP stack is not 
touched but the grace period when closing an ISO-TP socket is increased.

> I have created two testscripts where one plays the server and the
> other one is running a test and measuring the time how long
> it takes to transfer an ISO-TP Frame with 1000 Bytes.
> 
> Without this patch it takes about 35ms to transfer the frame,
> with this patch it takes about 145ms over vcan0.
> 
> Anyone an idea on this?

Yes. We now syncronize the removal of data structures to prevent a 
use-after-free issue at socket close time.

The synchronize_rcu() call does this job at specific times which leads 
to this extended time the close() syscall needs to perform.

> bring up a vcan0 interface with:
> sudo modprobe vcan
> sudo ip link add dev vcan0 type vcan
> sudo ifconfig vcan0 up
> 
> here are the scripts:
> --- isotp_server.sh ---
> #!/bin/bash
> iface=vcan0
> echo "Wait for Messages on $iface"
> while true; do
>      exec 3< <(isotprecv -s 77E -d 714 -b F -p AA:AA $iface)
>      rxpid=$!
>      wait $rxpid
>      output=$(cat <&3)
>      echo "7F 01 11" | isotpsend -s 77E -d 714 -p AA:AA -L 16:8:0 $iface
> done

IMO the issue arises with the use of isotpsend and isotprecv.
These tools are intended to get a hands-on impression how the isotp 
stack works.

This kind of use in a script leads to the creation and (now delayed) 
*removal* of isotp sockets for *each* single PDU transfer.

The better approach would be to write a C program that creates ONE 
socket and simply read() from that socket and write() to it.

This should boost your performance even more.

Is the performance a real requirement for your use-case or is this 
decreased socket close rate a finding which does not really affect your 
work?

Best regards,
Oliver

