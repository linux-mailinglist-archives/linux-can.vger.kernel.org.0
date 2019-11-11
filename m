Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F682F80C0
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 21:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfKKUAu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Nov 2019 15:00:50 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:38003 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKKUAt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Nov 2019 15:00:49 -0500
Received: by mail-pl1-f177.google.com with SMTP id w8so8250239plq.5
        for <linux-can@vger.kernel.org>; Mon, 11 Nov 2019 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Yb1SZ72zwzm3RHtwlSZQtwWBWTLYJwfjb1DDRD0EuU=;
        b=MSsMWJcx6qwMqbbVtukSCIOVSwvgkAYPAjh7KW2GtMDyrCmwHqju1Dw9YTlq+fM5nV
         f+BRqy4vk9CQuii2ZHS4dVw1TagQ5nSizNr6jvbZcwxlXlspAoyeSRUi8ZOy0jd+Ka0x
         43Cok3NbhriuulzWcZQHwViTriEVbc6YMQBCFlYt9OBmriT8KM4KHs5H+3vFxnjrpBdM
         Xw1zcjNI2nQ2fKKzV7KlENHm7T17hxiHjRFdTUHABaRwkUIMU2kVcMe2IoK1TUqgSFdJ
         XMaE5mJSdZA2krWLsA8txreRjXoC8+QtDz6MMkAuk3niMX/0HBBpu3aKaW61q+lH0v8w
         tLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Yb1SZ72zwzm3RHtwlSZQtwWBWTLYJwfjb1DDRD0EuU=;
        b=P1pCGK5s9XKT+b4QoQ/6kAcDspae5m0y7v2Lj5Zvbys0yGv59ygUXk3hGYy+/q6R09
         iUKgxBqjqdJTKibjJ01T3wmV5L/NyhmpX7+Zsg6xJ2OB7mQENbVO+2UHC+O3sfoN49Zt
         OcklIGTHq5Zh6czH7+Ms53iocfpdAQmVPAK9Rt5K4vRVctkRFGtsxj+MM4x+KAZCm4QY
         snY0m3YJa6UjYWydpY1qCfKX5yPRvuapqRyTVtLeeL3Ew/Aiod1u7Hf9oBMyDQ2v73GV
         8Bhj5bEVJP21qInKnObtFH1D3Vm+IAcrrdvnjfIvFoTGXNICGpQu5OVwa4CEUuuxQhUW
         d1vg==
X-Gm-Message-State: APjAAAX0KCcKs8FvS/0Z9mfioF6iwGdKtpDGVxP6twQUv+nUVfx0U0Op
        MRuPg4OLyXjBcIhAUQWWUa4QlCnI
X-Google-Smtp-Source: APXvYqyfr21X53vVyt9TDIroADyGZgkj2LBGkTKz1jwUCaQhvLDwJexyMWL5l4WctVBmcDQtEBkYQw==
X-Received: by 2002:a17:902:6ac6:: with SMTP id i6mr26883784plt.183.1573502448829;
        Mon, 11 Nov 2019 12:00:48 -0800 (PST)
Received: from x1 ([65.153.21.102])
        by smtp.gmail.com with ESMTPSA id n8sm214247pja.30.2019.11.11.12.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 12:00:47 -0800 (PST)
Date:   Mon, 11 Nov 2019 12:00:45 -0800
From:   Drew Fustini <drew@pdp7.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Drew Fustini <pdp7pdp7@gmail.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        andriy.shevchenko@intel.com, socketcan@hartkopp.net
Subject: Re: mcp251x: read oscillator frequency?
Message-ID: <20191111200045.GB7051@x1>
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Nov 11, 2019 at 11:28:14AM +0100, Marc Kleine-Budde wrote:
> I successfully got a mcp25625 (which is basically a mcp2515 with
> internal phy) running on a rapsi using the frequency printed on the
> oscillator in the DT-overlay.

I came across this patch by Andy on the linux-can archives:

[PATCH v2] can: mcp251x: Get rid of legacy platform data
https://www.spinics.net/lists/linux-can/msg02407.html

The description:
Instead of using legacy platform data, switch to use device properties.
For clock frequency we are using well established clock-frequency property.

I reads the clock-frequency property from device tree:
 
 	freq = clk_get_rate(clk);
-	if (freq == 0 && pdata)
-		freq = pdata->oscillator_frequency;
+	if (freq == 0)
+		device_property_read_u32(&spi->dev, "clock-frequency", &freq);
 

I feel like this is currently missing from mcp251x.c.  I don't see how it is 
reading the clock frequency from Device Tree as I don't see any code in the
current mcp251x.c to read device tree properties.

I would appreciate any insights to improve my understanding.

Thank you,
Drew
