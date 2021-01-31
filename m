Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE9309EFE
	for <lists+linux-can@lfdr.de>; Sun, 31 Jan 2021 21:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhAaUnY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 31 Jan 2021 15:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhAaUnV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 31 Jan 2021 15:43:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EDFC061573
        for <linux-can@vger.kernel.org>; Sun, 31 Jan 2021 12:42:41 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id r12so21122263ejb.9
        for <linux-can@vger.kernel.org>; Sun, 31 Jan 2021 12:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xEpVwShgOCPyRXefHv4qB90egGEeMYfOsaobZRZQleg=;
        b=TmLDboBsO++wr7hT+rV3DSIuaoYe+PG0CTuxzWwfEuUb1QVNGbsyvPAci9I1yJirv/
         oudeM0eJF8zGeTmqYp8ABi9pW5LOBZ7ILDi0aKwGa6Hteokojf68fpSaEKrXfB/DxgA6
         kQYTZ16n2uCs71tQbyJx9Jrkxe63CrUoBEnf/D7kCmFwdOafmz81HUIHqo5aegSCM23Q
         Qf3EhrXBm6g18fpsgfRxM0N2Hr1Ba/YbMwPUWatQRbSv266u2+l4IE3EmOgJLBEOY9vW
         Xp7fUXEsB1EwkBCUrN5265uIDqhD+EZ0ydbI4RKFMd5G13zd87qdD+W+qLLmTaj/u0b/
         HM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xEpVwShgOCPyRXefHv4qB90egGEeMYfOsaobZRZQleg=;
        b=bukdqjKdLWEAP27mbbZOMUmACstyRw3+JYiEQDmRq4yejDyRmCrE45zNkHeItAKCDt
         We30V8blcxCaoIn2N1kzTzbUEaaDvrZaF435o/QCupjmMWY3dL9pIPGH3L9Jk1jDmgyX
         r9fA7+8Lh/76zriohwrZDlHenZj2mRHVorE9M+LWiXfs1AzPPkCq0AG0TMqKbhspWj+V
         +v5w2fAO+OPZ0icb5vrfRKoBDWxWwumqVFv5UkYvBfdeAyI0M5epWwyxc8hqcVCdBdCJ
         L9FWr8+HwVrvZRkymwVwxu1j3I5Hlbfc6DUZnGgxoJi+RBgwM8l505+Ztf+sOgOecTqN
         dGzA==
X-Gm-Message-State: AOAM5319OB09JpLFaoooLL1CZHP/1MlnhpVVKr4LvXSNqJkXPkmZTiul
        3KEIgsIhDFFLWFTDHLAo54lM+7G8eAI=
X-Google-Smtp-Source: ABdhPJy1ab1Nlm4YlqHPQOYU4gMQ6IQ2QTpPXBXRo/YFKWwiHy4gdSRW0+jhj20PIenGfr3/CP4FJg==
X-Received: by 2002:a17:906:378d:: with SMTP id n13mr3060219ejc.386.1612125759819;
        Sun, 31 Jan 2021 12:42:39 -0800 (PST)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id fi14sm6942207ejb.53.2021.01.31.12.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 12:42:39 -0800 (PST)
Subject: Re: [Question] Sending CAN error frames
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
Date:   Sun, 31 Jan 2021 21:42:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-01-31 13:59, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 31.01.21 07:22, Vincent MAILHOL wrote:
>> Hello,
>>
>> The socket CAN API handles the CAN errors (as reported by the
>> microcontroller) by emitting some RX CAN frames with the
>> CAN_ERR_FLAG set.
> 
> Yes. This is the only intention.
> 
>> My question concerns the transmission path: I would like to
>> understand how drivers should handle *TX* CAN frames which have
>> the CAN_ERR_FLAG set.
>>
>> The socket API allows sending such frames. For example doing:
>>      cansend can0 20000123#0011223344556677
>> will generate such frames and it will reach the xmit() function of
>> the driver.
> 
> The reason to pass the frame as-is to the driver layer (including CAN_ERR_FLAG) is the possibility to test the correct behavior on the RX path, e.g. when you use the vcan driver.
> 
> On the sending path the CAN_ERR_FLAG has no functionality so far - at least it was not defined by the community.
> 
>> However, contrary to the other flags (EFF, RTR, FDF, BRS), the
>> ERR flag is not present on the data link layer. Instead, the data
>> link layer is responsible for detecting errors and signaling those
>> as soon as they occur (thus interrupting the transmission).
>>
>> While the ISO standard does not explicitly forbid having upper
>> layers generating such frames, it is not documented. Also, I am
>> not aware of CAN controllers allowing to generate error frames on
>> demand.
> 
> There are specialized CAN testers, e.g. IIRC Vector CANstress that can generate error frames on specific conditions (e.g. when detecting a specific CAN ID).
> 
> But I heave not seen CAN controllers that provide such functionality.
> 
>> My initial expectation is that those error frames only make
>> sense in the RX path and that we should drop such TX frames in,
>> for example, can_dropped_invalid_skb().
> 
> No. As written above the bit is defined to be valid in the RX path only and it makes sense for testing.
> 
>> However, after looking at the code of other drivers, it appears
>> that one (and only one) of them: the Kvaser hydra, does actually
>> check this CAN_ERR_FLAG flag in the TX path:
>> https://elixir.bootlin.com/linux/v5.11-rc5/source/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c#L1421
>>
>> I would be thankful if anyone knowledgeable about the Kvaser hydra
>> could explain to me how the device handles those error frames.
> 
> o_O - Yes, would be interested too!!

Hi Vincent and Oliver,

When the user passes a frame with CAN_ERR_FLAG set, the CAN controller will generate an error frame.
We got customers that use this for testing system robustness and fault reporting/handling.

We also got this implemented in the early version of kvaser_pciefd driver, but dropped it:
https://marc.info/?l=linux-can&m=154324867704480&w=2
Is this something that we should remove from kvasr_usb aswell?

Regards,
jimmy
