Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661D05A6CE5
	for <lists+linux-can@lfdr.de>; Tue, 30 Aug 2022 21:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiH3TPa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Aug 2022 15:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiH3TP3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Aug 2022 15:15:29 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E34505D
        for <linux-can@vger.kernel.org>; Tue, 30 Aug 2022 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1661886922;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=WUEQ+eMBiHkpQAl3LHj1qjSUD1iAPAj8pJbwiSH3Nb4=;
    b=cn55VwwfSdCw/G6JGt/Q78bnHGpXVM5irr+nyVh3eJ9+bwA3gO6Atyu6A9dHJmHmQk
    QfvwQoeI4UOy7oGbG7oXLaWrz5o7U2YjXTqcZtPMR20D5d/dH+KZCDTgqNhq3IKRQTid
    BiEUFrk16DaPKg++zMty0o/x4ngukxGY9m+41q2BI4SEvNkjN/cw3WqkhkOVdimFRPSh
    eMQ0BeVUYYaOjA3leStK7MZcKD8/ojM//nH3DXKsCsBc44AR7ef/ZrSAjs31C6u4COnx
    PmjJqOoL52FllfCoPXZ3hLR8uPxzusPv0Q2hKFSrObAYCzp7zmjtAhrEWzIPVajOcYn6
    ccSw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytISr63rQm6g=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d104::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y7UJFMQP8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 Aug 2022 21:15:22 +0200 (CEST)
Message-ID: <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
Date:   Tue, 30 Aug 2022 21:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Content-Language: en-US
To:     Jacob Kroon <jacob.kroon@gmail.com>, linux-can@vger.kernel.org,
        wg@grandegger.com, mkl@pengutronix.de
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jacob,

On 30.08.22 14:59, Jacob Kroon wrote:

> On 8/29/22 15:53, Oliver Hartkopp wrote:

>> Regarding your problem:
>> "BUG! echo_skb 0 is occupied" should never show up but I wonder if you 
>> probably have another CAN specific problem with your setup.
>>
>> Did you set up a CAN network with at least two CAN nodes, identical 
>> bitrate settings and 2x120 Ohms (== 60 Ohms) termination between CAN_L 
>> and CAN_H?
>>
> 
> I have double checked that both endpoints of the network are terminated 
> with 120Ohm resistors, and when I check CAN_H/CAN_L in an oscilloscope 
> they look ok, and within the spec. voltage levels.

https://www.compulab.com/wp-content/uploads/2011/08/CM-iTC-Reference-Guide.pdf

"it is necessary to add transceiver
hardware (see the SB-iTC reference schematic)"

I assume you have a transceiver, right? ;-)

What is the other endpoint? The EG20T and another (automotive) ECU?

>> Do you have another CAN node which can be attached to the EG20T setup 
>> (e.g. some ECU or an USB CAN adapter)?
> 
> Yes I do have a CAN analyser from Microchip. I guess I can record all 
> traffic with the analyzer, and compare it to what I see with "candump 
> can0" on the host. Or do you have some other suggestion ?

Yes, please add the CAN analyzer from Microchip too!

The problem with only two nodes is that you have to be very precise with 
bitrate settings and sampling points so that the receiving node needs to 
properly set the ACK to acknowlege the CAN frame.

I had been working with a MSCAN system some time ago and that wasn't 
able to talk to a commercial CAN tool until I added another node (from 
another CAN tool provider).

Maybe you can make the other node talk to the Microchip CAN analyzer and 
let the EG20T receive that traffic first.

Best,
Oliver
