Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA4F332365
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 11:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCIKyh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 05:54:37 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:9564 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhCIKyF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 05:54:05 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1615287238; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fiV6jvwYpUPg1I8EpXXgLPqs2mW8NPd81lqrs07wUhF2i3UqfAQwEbCIQhHnB1NQ+O
    XP/3Ja1OvjmGExF4nc8EXirLuXWUJvHxSrJk0sFolxLtD0RLNXdATvEHx/aNmxerhz8h
    EDx33rjJfDIRCr74+EaExLZ+eONB62WpHc9R5Dt7WA3oaHrhRyIq/yq/gPgkRkfdIqU6
    yBZaNZdtNBBQktdEk+iGS6pIBhsIRzslGCR4onicQM0wGpsTKCkWwzAW5mDXPaQR2Xy2
    aan2HM3rV5XtVgrg4dVQ8bQJj/nTIhAW6Wtr+JtHlDN2M8p3Ukhu6b7gx2mBEAficiy0
    Oavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1615287238;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=TUr8hMee9oBVAPFQltElLbewMPhq+mRSMtuoqJ7ZbWs=;
    b=VG5PA1/mR5JFYQrnAeQ97WPE56lxGDFEru5TBoGpwrazbscjGWBApGdsVWagJ43lg/
    2D5puQ2A0d16JqC/nd8A4IBg1Bo2bxa8USu24sNqBkpLYdnxjRGORSGAdJezvmyF1uz6
    Mm347I/AWVrxTbIADAkUF54XncS4q+9wnijD7FQCcGnUNf1uf2thHEz0+PREQVKpMEf1
    boSMtWsgoAw6BqcBoAq3VP0SO4jABIj/7tsiy87I7qC2/RywJ9gfAvjGB123m8sormnO
    DPG0ylgeSdvZ80MU841d+VQsnLBHt6yoMIFe1e562mKpBgdYuaqaNAP4P8jAVkuehzgW
    0kPw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1615287238;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=TUr8hMee9oBVAPFQltElLbewMPhq+mRSMtuoqJ7ZbWs=;
    b=kvDML2QPFjXMRKctqsToesY3Jk2yvTfl62MGC6y7O1bnf62Q3vtwxsiLJ/W3Yx/9RZ
    b3H1hyc9r2wywVR0Xfz4DNvd5zj9rpQJOfEbhsTBchlFQrulab0WhpepeVP/8lXsDmNB
    a152IFMkxHWpH91zD/pPf1yiZD7H6i0p5iWT/64G+/WT71E5ZKUgMkQ0Jau9fUco70Nr
    K31k1i1FQpNr966x8NBcsDZTC11zdib4baaAHocHk120ZzTa0ANdTJGHwIYoCOPg4JkF
    W2YorNCaAjh5R8aHY5aMFWKKSc0yjlH7zBQL49HErCN6jz2xeTQ9FR1vFoZI7z8O8Pks
    zqkA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xswl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.20.3 DYNA|AUTH)
    with ESMTPSA id 306d7ex29ArwEBW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 9 Mar 2021 11:53:58 +0100 (CET)
Subject: Re: [PATCH 3/3] can/peak_usb: add support of ONE_SHOT mode
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        linux-can Mailing List <linux-can@vger.kernel.org>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-4-s.grosjean@peak-system.com>
 <ae20aac4-28b3-ec5d-66e2-71ef2b507839@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <7272e91d-3e27-3b3d-fdbd-818cd073e761@hartkopp.net>
Date:   Tue, 9 Mar 2021 11:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <ae20aac4-28b3-ec5d-66e2-71ef2b507839@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 09.03.21 11:36, Marc Kleine-Budde wrote:
> On 3/9/21 9:21 AM, Stephane Grosjean wrote:
>> This patch adds "ONE-SHOT" mode support to the following CAN-USB
>> PEAK-System GmbH interfaces:
>> - PCAN-USB X6
>> - PCAN-USB FD
>> - PCAN-USB Pro FD
>> - PCAN-Chip USB
>> - PCAN-USB Pro
>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> 
> What happens if in one shot mode and the frame is not send? Who takes care of
> the echo skb?

ONE-SHOT only means that the CAN controller would not retry the 
transmission when e.g. loosing the arbitration or getting an error flag.

The sja1000 does it this way, when the TX interrupt flag is set in the 
interrupt register:

                 if (isrc & IRQ_TI) {
                         /* transmission buffer released */
                         if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT &&
                             !(status & SR_TCS)) {
                                 stats->tx_errors++;
                                 can_free_echo_skb(dev, 0);
                         } else {
                                 /* transmission complete */
                                 stats->tx_bytes +=
                                         priv->read_reg(priv, 
SJA1000_FI) & 0xf;
                                 stats->tx_packets++;
                                 can_get_echo_skb(dev, 0, NULL);
                         }
                         netif_wake_queue(dev);
                         can_led_event(dev, CAN_LED_EVENT_TX);
                 }


Do we need to check this for the other drivers?

Regards,
Oliver
