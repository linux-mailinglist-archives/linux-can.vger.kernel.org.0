Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74968D27F
	for <lists+linux-can@lfdr.de>; Tue,  7 Feb 2023 10:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjBGJS0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Feb 2023 04:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjBGJSO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Feb 2023 04:18:14 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A2123DA7
        for <linux-can@vger.kernel.org>; Tue,  7 Feb 2023 01:17:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675761475; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DG0BcoI5vcpVSz9M5DaGVKTMMFP/v2wU5mxTVWKNxaV3K57liq+q4Ey+MCIwrAmRCr
    ZQB3W1MUuBq15JjpDL2JbG7D+nYjf91YRA7iVgWZm/liIW2VBwwveQg+yJ/HTvm9Um+7
    a2mzs9QB1DQgQTC9UUyshd3uTn7KRedwaanIGc1Uh/aqelU71TGhD1oOmDuscQy0xcLY
    x6jWzy/stAA1GPaItIhV+rvovWVKdDCngy4oxvlerkgxo/yRD6iyeY72xDc1x7c3Ovaf
    fIEE+7bwvRGuyh1WcFYxiYK9C9pY7k3dfHZ+TWTvGZAz/QT9p0ZfJ84CwwZVpGO0K7Et
    jd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675761475;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VQD02W35v01RGPVkE5hiOsLLtgYMIslAdnrodD1hKaA=;
    b=kCJpkUwUSIf4aHBV+fSu+5ASPydVxciE9UslkyeG8CL6mrU8ovbH7BBOaoDzrhZN5d
    l9NlEiE981ipxsPB/cjhxO5Zf3vIb+241UIevpD7MqCeC1gKoOJOpAhtCUaczY+mbx1r
    uaZxjvg9dUPq6SzlpOfBljaULuQE7U2rjFvDZYQ8rsg3n7Ihr2xBpB3hQ3jF0IH0hKnk
    hXwevZVUoja6MV+pwo0vCHe/+t4JYLhE2DSmOrU+vIY+GEaYFAnWbc5HRFT2tQqUdODq
    LL7160bD01A0S1FeIbH8RAanINoNGzgFRMauwnN3Lwo8Q+34SjtQKdroO+kO64ozAHFU
    Lz/A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675761475;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VQD02W35v01RGPVkE5hiOsLLtgYMIslAdnrodD1hKaA=;
    b=coT5msfLg/FZhwNbhmkHJF5VoNR8gm4+/nW+aHQrpeXZ4ehlQ/6CiKrIVaogqiqPkh
    jvHy74iEwDmGxvgTb/J5cISUFvkKj9CQGMrK3bL39h1i2oZW7djp870UC221tAZsixNO
    cSSBa6tbyqN0qUcXxLos3i3ChFZT14+6p84MObTNoO4F3vNL6O+MJmdMJ3Txe9r2CSPn
    EOWGiITXJ1TACS9WB16m5HUsThfIQhYIQjWivAFpxzBDo2N7DoT7oQcmoljVz0BaLDDQ
    mzuuHi91jqbgVp7iLm1mrqpU/duAny9EnPzz137X05TGjrJh2LPGDzGZcIA0LdcGz/O9
    VFoA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USNbW+gMKb67ekIdBrit00vb0RFTw=="
Received: from [IPV6:2a00:6020:4a8e:5000:3841:88c3:2941:ee56]
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id qa71b9z179Htcnn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 7 Feb 2023 10:17:55 +0100 (CET)
Message-ID: <9e7141f8-6e3e-1988-af6c-5a9e7dae4f83@hartkopp.net>
Date:   Tue, 7 Feb 2023 10:17:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] can: proc: properly format table
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20230206194305.2827376-1-mkl@pengutronix.de>
 <20230206194559.lv5ana7slnw2u2st@pengutronix.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230206194559.lv5ana7slnw2u2st@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

not sure on which architecture your proc output was created.

On 2/6/23 20:45, Marc Kleine-Budde wrote:
> On 06.02.2023 20:43:05, Marc Kleine-Budde wrote:
>> The table "/proc/net/can/rcvlist_all" is garbled if the interface
>> names are longer than 5 characters.
>>
>> Consider IFNAMSIZ when formatting the table so that it looks like
>> this:
>>
>> | receive list 'rx_all':
>> |   device              can_id   can_mask  function  userdata   matches  ident
>> |    any                   000   00000000  8e807747  9bc49fd8         0  raw
>> |   device              can_id   can_mask  function  userdata   matches  ident
>> |    mcp251xfd0            000   00000000  8e807747  ec6d80a2
>> |   0  raw
>        ^^^^^^
> Doh! That's my fault, the proc output is OK. fixed.
> 

On my x86-64 with IS_ENABLED(CONFIG_64BIT) it looks even worse:

cat /proc/net/can/rcvlist_all

receive list 'rx_all':
   (any: no entry)
   device   can_id   can_mask      function          userdata 
matches  ident
    vcan0     000    00000000  00000000cb627637  00000000afdf543a 
  0  raw
   device   can_id   can_mask      function          userdata 
matches  ident
    vcan1     000    00000000  00000000cb627637  0000000020f218f6 
  0  raw

I wonder if we should clean up this proc stuff in general.

As you can see the "function" value is identical and points to "raw_rcv" 
but the pointer is (of course) a pseudonym to not leak any kernel 
pointer to the user space. IMO we could drop this column as the "ident" 
column identifies the can_rx_register() user anyway.

The 'userdata' column is still helpful to identify different socket 
instances while debugging. But maybe we can "fold" the address in a way 
that it is always 32 bit?!?

With such kind of clean up the output of a proc line would fit into 80 
chars again - even with your suggestion for IFNAMSZ.

What do you think about such clean up?

Best regards,
Oliver
