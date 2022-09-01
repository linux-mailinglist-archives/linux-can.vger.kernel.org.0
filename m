Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA745A9D33
	for <lists+linux-can@lfdr.de>; Thu,  1 Sep 2022 18:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiIAQgY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Sep 2022 12:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiIAQgS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Sep 2022 12:36:18 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5956E8A4
        for <linux-can@vger.kernel.org>; Thu,  1 Sep 2022 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1662050130;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=1iLEfBmzPHBL11S1EYxC41CJPqMX8oDEcQT+itHRN0I=;
    b=sff95zZ9j5wse3ShwQSsHsR31Aq1js5xVvueaCB92vA/tLaUqlnphoYboUCipDTlAd
    fzWESd99nLdnrT/E+OTKV0hs+V/MY9cpUvhoxy2ri5mIaiokuPQ0hymdxn/iPZNgWbps
    aOHsOVRVEVo5mNqXSd/E1QMayURQhhOnvOgWmzuOIx5C1dZnZpfZauTeZYP8w9DSj7SI
    A/v6VmjM95AqQbrWBSYhSrIHDrzA1RsUL8ONEXTSpqwz477yO8Lx4GZr44GarwTZcraW
    BBUkiJhXXwRPGybVVDVlH7xS2zsItD/x2fShGtwwIoRObDo/SwEmxec7PCot6BnfkSdw
    uV4A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytISr63rQm6g=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d104::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y81GZUXbK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 1 Sep 2022 18:35:30 +0200 (CEST)
Message-ID: <68dd96fb-69e7-d82f-75b3-610afe9ae0b8@hartkopp.net>
Date:   Thu, 1 Sep 2022 18:35:24 +0200
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
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jacob,

On 01.09.22 11:38, Jacob Kroon wrote:
> On 8/30/22 21:15, Oliver Hartkopp wrote:

>> I assume you have a transceiver, right? ;-)
>>
> 
> Yes,, all nodes are using a TJA1050 transceiver
> (https://www.nxp.com/docs/en/data-sheet/TJA1050.pdf)

Good!

>> What is the other endpoint? The EG20T and another (automotive) ECU?
> 
> Currently I have 4 nodes in the network, EG20T is in one end.
> 

Ok, that's a good base for testing.

>>>> Do you have another CAN node which can be attached to the EG20T 
>>>> setup (e.g. some ECU or an USB CAN adapter)?
>>>
>>> Yes I do have a CAN analyser from Microchip. I guess I can record all 
>>> traffic with the analyzer, and compare it to what I see with "candump 
>>> can0" on the host. Or do you have some other suggestion ?
>>
>> Yes, please add the CAN analyzer from Microchip too!
>>
>> The problem with only two nodes is that you have to be very precise 
>> with bitrate settings and sampling points so that the receiving node 
>> needs to properly set the ACK to acknowlege the CAN frame.
>>
>> I had been working with a MSCAN system some time ago and that wasn't 
>> able to talk to a commercial CAN tool until I added another node (from 
>> another CAN tool provider).
>>
>> Maybe you can make the other node talk to the Microchip CAN analyzer 
>> and let the EG20T receive that traffic first.
>>
> 
> I used "candump can0 -l" on the EG20T host to capture the traffic, and 
> then connected an CAN USB analyzer to the network and used that to 
> capture the traffic. One thing sticks out. This is the log from the CAN 
> USB analyzer:
> 
>> ...
>> 505.7052;RX;0x464;3;0x01;0x01;0x00;;;;;;
>> 505.7052;RX;0x464;3;0x00;0x00;0x00;;;;;;
>> 505.7063;RX;0x65;64;;;;;;;;;

What should this be?

A length of 64 and no data ??

This is no valid CAN frame.

>> 505.7662;RX;0x440;3;0x32;0x20;0xFA;;;;;;
(..)

> 
> Note the third message from the top. This is what "candump" on the host 
> logs:
> 
>> ...
>> (1662022485.638794) can0 464#010100
>> (1662022485.638940) can0 464#000000
>> (1662022485.699405) can0 440#3220FA

The correct CAN frames are displayed correctly.

>> ...
> 
> It fails to see the 3rd message from the previous log. What would that 
> indicate ? The CAN analyzer sees the message, but the EG20T doesn't.

Don't know if this is an error on the CAN bus. You can also print error 
messages of detected CAN bus problems with adding an error message filter.

See 'candump -h' :

candump -l any,0:0,#FFFFFFFF
          (log error frames and also all data frames)


Best regards,
Oliver
