Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4653A443412
	for <lists+linux-can@lfdr.de>; Tue,  2 Nov 2021 17:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhKBQ5L (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Nov 2021 12:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhKBQ46 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Nov 2021 12:56:58 -0400
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Nov 2021 09:04:45 PDT
Received: from mailproxy06.manitu.net (mailproxy06.manitu.net [IPv6:2a00:1828:1000:1111::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0E6C06120C
        for <linux-can@vger.kernel.org>; Tue,  2 Nov 2021 09:04:28 -0700 (PDT)
Received: from [IPv6:2001:a61:b2e:8401:5530:8b54:2e31:3f35] (unknown [IPv6:2001:a61:b2e:8401:5530:8b54:2e31:3f35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: wg@grandegger.com)
        by mailproxy06.manitu.net (Postfix) with ESMTPSA id 601A15800BF;
        Tue,  2 Nov 2021 16:59:13 +0100 (CET)
Subject: Re: sjw in can_calc_bittiming
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        =?UTF-8?Q?Matthias_Wei=c3=9fer?= <m.weisser.m@gmail.com>,
        linux-can@vger.kernel.org
References: <CAO8h3eEcK7c6M5T88K0MO6eQk64DY+85Mzsi5zdT9tV9mxiMfw@mail.gmail.com>
 <0a539c49-b92e-892e-5848-613ff745c283@hartkopp.net>
From:   Wolfgang Grandegger <wg@grandegger.com>
Openpgp: preference=signencrypt
Autocrypt: addr=wg@grandegger.com; prefer-encrypt=mutual; keydata=
 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
 8QEfHnPzgykCs2DOOQ==
Message-ID: <34585cc9-eb4b-82fd-607c-19ae20064e7c@grandegger.com>
Date:   Tue, 2 Nov 2021 16:59:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0a539c49-b92e-892e-5848-613ff745c283@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

Am 02.11.21 um 16:36 schrieb Oliver Hartkopp:
> Hi Matthias,
> 
> On 02.11.21 16:03, Matthias Weißer wrote:
> 
>> we recently had a case here where one member of a CAN bus couldn't
>> receive
>> frames with data content of only zeros:
>>
>> $ cansend can0 123#0000000000000000
>>
>> After some investigation we found the root cause to be a slight
>> difference
>> (about 1%) in actual bitrates of the two members. The one with showed the
>> RX errors had a sjw value of 1 and a lot of time quanta (40) due to
>> the 40MHz
>> CAN clock.
>>
>> This leads to a build up of phase error (as sjw is not able to
>> compensate for
>> enough of the bitrate difference) which at some point leads to a framing
>> error due to missing a stuff bit. Playing around with the sample point
>> can
>> improve or worsen the behavior.
>>
>> We can fix this quite easily by specifying a higher sjw value.
> 
> You can specify the sjw value with the ip command (for CAN FD there is
> also a dsjw). And IIRC you can set it to the max. value for your CAN
> controller if you define sjw to be 4.
> 
> Best regards,
> Oliver
> 
> $ ip link help can
> Usage: ip link set DEVICE type can
>     [ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
>     [ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
>        phase-seg2 PHASE-SEG2 [ sjw SJW ] ]

This usage description is not totally correct! It is also possible, to
increase "sjw" together with the bitrate, e.g.:

  # ip link set can0 type can bitrate 250000 sjw 2
  # ip -d link show can0 | grep sjw
      tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 2
  
Here is the code for it:

  # cat dev.c
  ...
        /* check for sjw user settings */
        if (!bt->sjw || !btc->sjw_max) {
                bt->sjw = 1;
        } else {
                /* bt->sjw is at least 1 -> sanitize upper bound to sjw_max */
                if (bt->sjw > btc->sjw_max)
                        bt->sjw = btc->sjw_max;
                /* bt->sjw must not be higher than tseg2 */
                if (tseg2 < bt->sjw)
                        bt->sjw = tseg2;
        }

Wolfgang
