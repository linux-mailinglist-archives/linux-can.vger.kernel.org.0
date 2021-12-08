Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4732F46D465
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 14:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhLHNav (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 08:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhLHNav (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 08:30:51 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381C0C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 05:27:19 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 13so3837706ljj.11
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 05:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i3aWnsDUys1nismMymjZAGD+SKr5JPkButJ0wexgcow=;
        b=P1eHzIYl7qc9RaoVU92WvMJDRB23LLX6hKY2dRLe7ya1rDhtF4D4cru64Ig4WzcObG
         bnWNunC8HgWCSroHdwr59cuhN0tfAfYXVxkd17ZMbyULBBqKxFVHDPGpBTceZN/q2JGA
         Sq95h9BTDNBJkoIQ6vyyIY6uKszFuS1TlChl9CL9TiicBeMl8m+CWIBtpsc276lpnnx8
         7r7iDYxUuUr5X0jJMLg3n9eZksm4FIQBTKjniIeE6TrbgRh3AUfnaeS/CBEA6QMZV1cB
         CelvAESYxVzK1FUX4UDn6wX2aG1jx/l5vBlkN4JwhE5+my/I1kTGWycwXWo5vz9DxetC
         t2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i3aWnsDUys1nismMymjZAGD+SKr5JPkButJ0wexgcow=;
        b=Z4og0lUQPnqzCMoDHzRkNALZn2C/bhJQrgnAjrmFV5o9tbUDUo81l994yhbmAVwJqR
         P8LRs5Srp9eODZ29iLN+NRFKgp4bHzmKj+WjglFHxnuthziuxcWsXhZ0TBRTo2XDwZmz
         D+HMXOoEPLxsZc5/bnOicvO4kbfq8o49Lo2m+u1tgaLZH5GiMuyFH4MVrRJ53hwW82qr
         CgdJg3VOpsV/ENymqmYB1BYHqA7BaStyS1ArR6r3qveVAvA1mgUErssaM446PkobEGP7
         8ZWhDog9I3HS1Ldyn0I2IMxWXOD33Q8HGRTw+6lv+aMnkDr18zi35mAZvC8LMZb+Fui0
         dEbA==
X-Gm-Message-State: AOAM5314M5mA5ncOLT7GgIL9RRmQiOdcSDd6Exw4/np5Ls3Duabju1AH
        B3+nXml3VDsyppfAxOSdr43xQg==
X-Google-Smtp-Source: ABdhPJxBeDLNuzL6mfAk9wPDMqYnRQjaIt0uj/PtCKRUK6BGFIqGGlwZmuW6SnbRTbn4BQAyEG1bFA==
X-Received: by 2002:a2e:9dcf:: with SMTP id x15mr5075767ljj.223.1638970037555;
        Wed, 08 Dec 2021 05:27:17 -0800 (PST)
Received: from [10.0.6.3] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h24sm269405ljg.106.2021.12.08.05.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 05:27:17 -0800 (PST)
Subject: Re: [PATCH v3 4/4] can: kvaser_usb: Get CAN clock frequency from
 device
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20211208115607.202859-1-extja@kvaser.com>
 <20211208115607.202859-5-extja@kvaser.com>
 <20211208124810.umnfw3f3fvev3rxw@pengutronix.de>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <f978d9ea-8d2d-51db-a141-5019f1e45496@kvaser.com>
Date:   Wed, 8 Dec 2021 14:27:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20211208124810.umnfw3f3fvev3rxw@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-12-08 13:48, Marc Kleine-Budde wrote:
> On 08.12.2021 12:56:07, Jimmy Assarsson wrote:
>> Get the CAN clock frequency from device, since the various Kvaser Leaf
>> products use different CAN clocks.
> 
> Help me classify this patch. Is existing hardware that uses this driver
> broken without that patch?

Yes multiple old devices are affected by this bug.
   Fixes: 080f40a6fa28 (can: kvaser_usb: Add support for Kvaser CAN/USB 
devices)

Best regards,
jimmy

> regards,
> Marc
