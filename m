Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3C268D5B7
	for <lists+linux-can@lfdr.de>; Tue,  7 Feb 2023 12:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjBGLkM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Feb 2023 06:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjBGLkL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Feb 2023 06:40:11 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD7A1167C
        for <linux-can@vger.kernel.org>; Tue,  7 Feb 2023 03:40:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675770007; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=D0vS9DdydzoSluKkTVqLNSwtv+161Y/nv4haDKiCUT+nJHUNI4T8x6sUtZyaviUMeE
    8z8Ou65mFRNFbk1q8wbDEcQItnVWo2UQ7Q9n7zc335IdsAW1tiIB69+b9hTEy+d6RaKx
    yUqJhckWmvVF8AMSIvFUIbs0cDl+7fWrq4GeYvlhZ8LCQqU9IwVMytF/FqJFZZS6MOkL
    8Kqopsxzyz3/VuP00PQANtSirwv0ql5racy+9zfz5PF1oBy20E+JOGDQI7iX3ODFcZp3
    b0p//Eon5t5Djaj+b/J5AK4TylQIzNUoU/NieI5M9GMkGnRMj6Aaw9inU/Y429ASsoRQ
    iT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675770007;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LnCt92lfRqiAStwbwZSi3KLPRzbLwhyso3g47+hcdhc=;
    b=k6ZVIvTgcAJOiwvLJjct5zm1GZnoc6OUbmdz84uRDRDWL8yu41Qx5EBh3uF1O9VciZ
    d3nRc1zxPg4w4fkCaCE9cUNteYkmrcOwiLjUo1mM+kOe/afHGBfvHfXpoxGEJftUeEaS
    7Icn+jqQ2T9ijVJnsaoqCVmrVaW1YRCW7PzQYC/L+WoJ/zsl+vFTbqPVYUu634AknCsB
    D4u6XopCDljslYyG/g8WOdkKLAucWXKGCap5vs/PbdNxMReDUSGpp8ipRLGD62+PzZva
    sMJIilQxaX1q2McZbCkO8cvrC/Ihb7E7l5E/0PccQjHxYtMZ/01cKCFq8R7aWJu/WfC/
    M0Lw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675770007;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LnCt92lfRqiAStwbwZSi3KLPRzbLwhyso3g47+hcdhc=;
    b=lViNkPJoc7DaGBM7NU0eWhy4qyvKuK1HKz37iM5w3ZaNmUzoCfon6Zs4+P/08El92+
    y2n351rXhfK2GZN2xCoM/i05t2GzKmSgo9Q7M/Lie49IXnGaUfYXNRlyWtjM0wTw22OC
    R3QTJPCvhUq0WvFSuvTjanqkIVVSAcGKZT9mogMfQ0hz0cP1Ha046/FNIoR8bssc36Ql
    qjm0rRa34sBVI/kJGW12fHvkkcr5rMSmX8cj/tWv8CcfDyTiUVhbXk9mBGFUGFUmmiP0
    uJDkU734txJ/OwWmA5WuDkBZJ5acHuV7kRVMOFIEBn7LUVbeGOrErFVU2kBYbEdd6UIR
    CwbQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USNbW+gMKb67ekIdBrit00vb0RFTw=="
Received: from [IPV6:2a00:6020:4a8e:5000:3841:88c3:2941:ee56]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id x84a76z17Be70LV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 7 Feb 2023 12:40:07 +0100 (CET)
Message-ID: <22087122-a054-b751-f403-c075ec5f1ca3@hartkopp.net>
Date:   Tue, 7 Feb 2023 12:40:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] can: proc: properly format table
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20230206194305.2827376-1-mkl@pengutronix.de>
 <20230206194559.lv5ana7slnw2u2st@pengutronix.de>
 <9e7141f8-6e3e-1988-af6c-5a9e7dae4f83@hartkopp.net>
In-Reply-To: <9e7141f8-6e3e-1988-af6c-5a9e7dae4f83@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,TRACKER_ID autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

What about this kind of layout?

           device    can_id  can_mask  userdata  matches  ident
1234567812345678       123  12345678  12345678  1234567  isotpe

           device    can_id  can_mask  userdata  matches  ident
             can0  12345678  12345678  12345678  1234567  isotpe

           device    can_id  can_mask      userdata      matches  ident
1234567812345678       123  12345678  0000000012345678  1234567  isotpe

           device    can_id  can_mask      userdata      matches  ident
       mcp251xfd0  12345678  12345678  0000000012345678  1234567  isotpe

12345678901234567890123456789012345678901234567890123456789012345678901234567890

Only the "matches" could lead to a length beyond 7 characters then and 
would lead to a garbled output at the end of that line.

Best regards,
Oliver

On 2/7/23 10:17, Oliver Hartkopp wrote:
> Hi Marc,
> 
> not sure on which architecture your proc output was created.
> 
> On 2/6/23 20:45, Marc Kleine-Budde wrote:
>> On 06.02.2023 20:43:05, Marc Kleine-Budde wrote:
>>> The table "/proc/net/can/rcvlist_all" is garbled if the interface
>>> names are longer than 5 characters.
>>>
>>> Consider IFNAMSIZ when formatting the table so that it looks like
>>> this:
>>>
>>> | receive list 'rx_all':
>>> |   device              can_id   can_mask  function  userdata   
>>> matches  ident
>>> |    any                   000   00000000  8e807747  9bc49fd8         
>>> 0  raw
>>> |   device              can_id   can_mask  function  userdata   
>>> matches  ident
>>> |    mcp251xfd0            000   00000000  8e807747  ec6d80a2
>>> |   0  raw
>>        ^^^^^^
>> Doh! That's my fault, the proc output is OK. fixed.
>>
> 
> On my x86-64 with IS_ENABLED(CONFIG_64BIT) it looks even worse:
> 
> cat /proc/net/can/rcvlist_all
> 
> receive list 'rx_all':
>    (any: no entry)
>    device   can_id   can_mask      function          userdata matches  
> ident
>     vcan0     000    00000000  00000000cb627637  00000000afdf543a  0  raw
>    device   can_id   can_mask      function          userdata matches  
> ident
>     vcan1     000    00000000  00000000cb627637  0000000020f218f6  0  raw
> 
> I wonder if we should clean up this proc stuff in general.
> 
> As you can see the "function" value is identical and points to "raw_rcv" 
> but the pointer is (of course) a pseudonym to not leak any kernel 
> pointer to the user space. IMO we could drop this column as the "ident" 
> column identifies the can_rx_register() user anyway.
> 
> The 'userdata' column is still helpful to identify different socket 
> instances while debugging. But maybe we can "fold" the address in a way 
> that it is always 32 bit?!?
> 
> With such kind of clean up the output of a proc line would fit into 80 
> chars again - even with your suggestion for IFNAMSZ.
> 
> What do you think about such clean up?
> 
> Best regards,
> Oliver
