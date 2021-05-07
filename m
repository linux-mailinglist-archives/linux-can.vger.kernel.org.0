Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DBF3766EA
	for <lists+linux-can@lfdr.de>; Fri,  7 May 2021 16:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhEGOOA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 May 2021 10:14:00 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:16528 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhEGON7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 May 2021 10:13:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620396774; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a+qP/NL7YlZ10oM3I1uP2qx26cxLIO8MadQjh0qvh8nuzrYGvu7ksk5PsZ8hwRapt2
    Ig5LQ5t0xnfOZS6Hxnj/zkUdtjslMLZaA3d3wGxMkA6B162uvZ5bHCqRvsdOjWlyKfzY
    9Hv5Tzbhwe18641L4jf30OLEyYbvvEZ+fhXo8seeknYBs7yBu6obZkhrgJNtToaxlsMC
    6yzsPiaV/49vUkCYmHw1NH53JkKVbzp4+2gp6GMB09wJZTyu7KbNC4RjYVdD/72eZS36
    TVITZXdXdJ05QoKYrUqKZJiyzq/69njx0RSRL2benK5mxnX+RoxWlUPNTm5CjylKtP2E
    dQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620396774;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=wuQO0ztmgoxnA5vcqsYvXqRFqmvfs3MxEjQ388FFzqo=;
    b=Us41pJyjAopXRt4Yk3RvlLKy9Xn6gPV6rOn87vhAP7dwEyV0PiUDvRsfDcWK/+sCHm
    VH+6p40FbYWUfmKT0ljs1fQ3Mjn5XDjulFE+LC6XQXgLKE9zT/UhkauF63aW5yDlWhx1
    JPFWw4Xh/yhQ19fRXPyGTWxTxPgHifcX6OAlrlFRF71Lo4/bRqjyWoAzpq7e8ctMd7+k
    7y7wQuy7q2s+IgPCurFanH7Q1Nq2RrgUGStVDTTyS/Cg0BomK495WlKYCLIhm9MAzx3o
    u8nozIH4Abg5V6S3Xojc+6Kz7Kfry7+5Sc0tPfL67BM9KXKO47cDK4hp1NGsrY+2j5hi
    amQA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620396774;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=wuQO0ztmgoxnA5vcqsYvXqRFqmvfs3MxEjQ388FFzqo=;
    b=VI/eQc/A9dmipYAvGXxxZ7MRobGG+TAq6ayKR3HxnUobM/r+tFBZ4Y+pQog3lOI437
    nV+IzSoMniUmkyJzk3G5UldrCP6x4Y2/QjyxGAgC+7NBVJR9prrhIw1UNWZFyjX9Bn9y
    jxsUWquFE/ijk9wGxF8oFbAUZH5XTytnE5+yWjXDPB+Qzxt3edj96KokSctRgQNuiDlZ
    xqxgNPZK/sCD2P/Qp4NWhmYnR1ngY9Q3FZMNskcmqjqljXQLsVZoVolZUvWU4HsFwYDP
    BQtWJdm61+WWPEHVRP0Spv5oApZ4QVKv81hTfq2cTnnlyFSHKzRHqiiq5y0MV8BXabta
    dO8A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR8J8xswl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.25.6 DYNA|AUTH)
    with ESMTPSA id e040b6x47ECs2ph
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 7 May 2021 16:12:54 +0200 (CEST)
Subject: Re: [PATCH RFC] can: isotp: isotp_sendmsg(): return error on FC
 timeout on TX path
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <e9ebf4ab4b1a431eac24a21ab8379894@liebherr.com>
 <20210507125017.hu3rcilzcw4rknof@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d691ed18-d9d4-bf78-d506-cbd7a74dba6b@hartkopp.net>
Date:   Fri, 7 May 2021 16:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210507125017.hu3rcilzcw4rknof@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On 07.05.21 14:50, Marc Kleine-Budde wrote:
> On 07.05.2021 12:29:33, Sottas Guillaume (LMB) wrote:
>> Indeed the first version (with positive value) does not work, but I
>> just tested the V2 of the patch, and work like a charm. Let me know if
>> I can help to get it integrated
> 
> You can send you Tested-by to that v2 patch, like Oliver did to the v1.

Of course I did the test to my adapted version which now became the v2 ;-)

Best,
Oliver

> The patch will be part of my next pull request to net/master.
> 
> regards,
> Marc
> 
