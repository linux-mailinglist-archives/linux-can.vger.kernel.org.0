Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34565309CCD
	for <lists+linux-can@lfdr.de>; Sun, 31 Jan 2021 15:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhAaOUU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 31 Jan 2021 09:20:20 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:34969 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhAaNDc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 31 Jan 2021 08:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1612097972;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
        From:Subject:Sender;
        bh=4svtcZ7PtoTwqORkNzZoJJcMOmxrfTNQBl77Z1eQYB8=;
        b=FRidVytCA+1Pp0COO2ahjfZtNK2DJujDf8LaGScbIz4HK/t5ZwmeDJ1KXX8lKmgYdK
        J8OWDFZFAca6/XvwklEezCaNUeGLOAtVRz8HhmzrvxZwYqt3bNHxhU8aUWNcHug+RnkS
        VVC2xQoD74b5Kyq7I/RtDUloMUhJaBuGaWm/HNGtPAVxt8dAGChmHuThofFmZ7qaR0Ac
        vhIqbFIwf32OA1OEuPnk0ts2pf+I+ooVOqPtrnRWDjPZBNAK+DlrmF/dL6VDIPpcW7y8
        1oqcagX0TV7Hmlx/zv8EZhLWh1hYNWSHeKZA71z4ahPeAC0lxLBD+3uyFUMC3KwM7NLJ
        Xmng==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rnbMYliT57TylTcjXQ=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.16.0 DYNA|AUTH)
        with ESMTPSA id w076a1x0VCxW90X
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 31 Jan 2021 13:59:32 +0100 (CET)
Subject: Re: [Question] Sending CAN error frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net>
Date:   Sun, 31 Jan 2021 13:59:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On 31.01.21 07:22, Vincent MAILHOL wrote:
> Hello,
> 
> The socket CAN API handles the CAN errors (as reported by the
> microcontroller) by emitting some RX CAN frames with the
> CAN_ERR_FLAG set.

Yes. This is the only intention.

> My question concerns the transmission path: I would like to
> understand how drivers should handle *TX* CAN frames which have
> the CAN_ERR_FLAG set.
> 
> The socket API allows sending such frames. For example doing:
>      cansend can0 20000123#0011223344556677
> will generate such frames and it will reach the xmit() function of
> the driver.

The reason to pass the frame as-is to the driver layer (including 
CAN_ERR_FLAG) is the possibility to test the correct behavior on the RX 
path, e.g. when you use the vcan driver.

On the sending path the CAN_ERR_FLAG has no functionality so far - at 
least it was not defined by the community.

> However, contrary to the other flags (EFF, RTR, FDF, BRS), the
> ERR flag is not present on the data link layer. Instead, the data
> link layer is responsible for detecting errors and signaling those
> as soon as they occur (thus interrupting the transmission).
> 
> While the ISO standard does not explicitly forbid having upper
> layers generating such frames, it is not documented. Also, I am
> not aware of CAN controllers allowing to generate error frames on
> demand.

There are specialized CAN testers, e.g. IIRC Vector CANstress that can 
generate error frames on specific conditions (e.g. when detecting a 
specific CAN ID).

But I heave not seen CAN controllers that provide such functionality.

> My initial expectation is that those error frames only make
> sense in the RX path and that we should drop such TX frames in,
> for example, can_dropped_invalid_skb().

No. As written above the bit is defined to be valid in the RX path only 
and it makes sense for testing.

> However, after looking at the code of other drivers, it appears
> that one (and only one) of them: the Kvaser hydra, does actually
> check this CAN_ERR_FLAG flag in the TX path:
> https://elixir.bootlin.com/linux/v5.11-rc5/source/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c#L1421
> 
> I would be thankful if anyone knowledgeable about the Kvaser hydra
> could explain to me how the device handles those error frames.

o_O - Yes, would be interested too!!

> Also, please comment if you are aware of any use cases for TX
> error frames.

Done.

Best regards,
Oliver
