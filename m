Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD030BE00
	for <lists+linux-can@lfdr.de>; Tue,  2 Feb 2021 13:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBBMQw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Feb 2021 07:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhBBMPc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Feb 2021 07:15:32 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4A9C06174A
        for <linux-can@vger.kernel.org>; Tue,  2 Feb 2021 04:15:01 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f19so23685732ljn.5
        for <linux-can@vger.kernel.org>; Tue, 02 Feb 2021 04:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pCDy5YfbwDHLALXOdAXnz8ewbk93ecm2qcft12JwXCw=;
        b=ZZj5wuXr7WzI+uduT8R8PRdNI06L9GglnQMrHIu4nF0SV/eXoDsq6nbl4ul0cRiSfo
         Z/8ZelnxEVuQmnsv8DY/frtn+sx81D3+CJpiIjEH2uIIHvgjazYcE7SF7WcztoHLRF8/
         pw/I94osh2bNsWtkvziDHbnQEdkSABH8XyfF0HsPq76GuEi2QfvQCfKvMyO3DzssZ35x
         yDyaZI4M/npqU4bBZc600vvSrOHk+RCV4NXh+B1d3OmQy4VzOeu85omQEM5tfCnQMKD8
         Pt2ETdkSa1sA0RIyRuUwmk8xiZScvLRvmTLF12UgQf8FITw5Pa74UCad/3lNbVtsWW/a
         Klbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pCDy5YfbwDHLALXOdAXnz8ewbk93ecm2qcft12JwXCw=;
        b=J6veJANcZapubqvZUGuxl+M0N6Xzg/tDxWgqsitYBk0UIqbWLmEvhwq/f38c6RlO9/
         jtVRxLfdtJvAw6wlnpGkzb7Zp5LVgbphqVUe8N1BaAs7+QOA6ukQB6T6+8sCBiKa/C8H
         XTIrPfgoF09w/d422h5afxMjW/T+dO4y6WAcswAz83ALKYT+eyZA9dNbwwieS0w0V7Pu
         yyz6WTwXDg45cRW2SKuaj8GZcto5cYTAU5tHHtI01O3llQbRLYi4REpUYVDQMPiruhv0
         AfHUcRV+EtL/x1yYog17NrMWOpkvmrNgt2Mt5GSbZh3JoBxIObFFCkJw+khTCyxm6wom
         UTLg==
X-Gm-Message-State: AOAM5330JuJx+w4lMwWp/HKrEOaFygr759GKF1uDyaNRS6ZgrcbbfU+A
        abm74xVEgz+/GGVDj8LGqovmHlGNxlRYTmDq
X-Google-Smtp-Source: ABdhPJynAnoPc/Hl8yQ8KAff5E5aGM0HJ676rDyHrUC2ROFaC34YyBl5MWSRT1M8AI96hTIk1Nq3tg==
X-Received: by 2002:a2e:54d:: with SMTP id 74mr12497806ljf.44.1612268100041;
        Tue, 02 Feb 2021 04:15:00 -0800 (PST)
Received: from [10.0.3.39] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id m2sm3281792lfg.86.2021.02.02.04.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 04:14:59 -0800 (PST)
Subject: Re: [Question] Sending CAN error frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        linux-can <linux-can@vger.kernel.org>
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net>
 <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
 <CAMZ6RqJWrObGZRwyA1kD5cEZRUd_-4zt8rsMR+zZPLpxD6AWAQ@mail.gmail.com>
 <1debcaeb-71c7-6b78-88b3-7f121a33c1c1@kvaser.com>
 <CAMZ6Rq+ObkS2RDFbgbPP7HZH26WbN-eoLeQyiY6+CpDGYjE10w@mail.gmail.com>
 <17b14b11-87bf-9508-0da5-1031c5d5e132@pengutronix.de>
 <20210202082340.GA23043@x1.vandijck-laurijssen.be>
 <8050d433-591c-2d1f-f0c7-ffa92e33032d@pengutronix.de>
 <cac31b51-514d-462b-fe48-4c3bea8b28fd@hartkopp.net>
 <1b82f875-5884-3bf6-7891-2e4461d2a72a@pengutronix.de>
 <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net>
 <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <a0ddebb0-8023-dde0-dd5d-f626cc285310@kvaser.com>
Date:   Tue, 2 Feb 2021 13:14:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-02-02 11:00, Vincent MAILHOL wrote:> The echo would be special 
here.  We have to remember that the
> payload of the CAN_ERR_FLAG frames is an arbitrary design. This
> payload has no meaning for the data link.
> 
> When we echo back the frame, only the DLC, CAN ID and payload of
> the TX frame are irrelevant (except for vcan).
> 
> My current idea would be to follow what Kvaser did: they send the
> frame and the device reports the error flag (c.f. the example
> given by Jimmy above). So the echo feature would not be used
> for error flags.
> 
> @Jimmy, could you confirm my understanding? Do you use the echo
> functionality for error flags in the Kvaser driver?

I had to double check how this works.
When we get an skb with a frame where CAN_EFF_FLAG is set,
we will set the corresponding bit for the CAN controller, and
copy the rest of frame content (id, flags and data), and call
can_put_echo_skb(). Same as we do for all other packages.

We will receive a "TX ACK" for this package (from the USB device), and
we call can_get_echo_skb(). However, it looks like the "TX ACK" is
dropped, probably because CAN_EFF_FLAG is set.

We will also receive the generated error frame, and eventually call
netif_rx(skb). It is the same behavior for all the devices connected to
the bus.


The "TX ACK" path in the kvaser_usb driver is wrong, and it happens to
be that the ACK is not passed to the user. We also increment the
tx_packets and tx_bytes (depending on the data in the frame) stats.
I'll fix this once we know what the API should look like.

Regards,
jimmy
