Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B647139D9A
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2020 00:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgAMXog (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jan 2020 18:44:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45957 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgAMXog (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2020 18:44:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so10752444otp.12
        for <linux-can@vger.kernel.org>; Mon, 13 Jan 2020 15:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hWr5fTf0UvM/FdokqnbY78OahK5vgKtckbIjPFsKcM=;
        b=EB/Svwhu9PurDnkMsiR2ZxdYV2YmdAOFH6tvgzAb50fsSSchJiO3LOszBbMW8KtOlg
         yDqIxu5tOIq0YqaBM0mF/oSM6BdoyWZZwFTVIw4wKQNZo2XZziFIwgjnqnPk7o8B/irC
         RRJ15EMBbkJt41w7UP9JJ9lXfdlqNscExg/Q65XoxHGw1lSnWGq+oQLtSt2bDyG2juhT
         k5gqnhsrFrd2UO8jC6bxhmOENhXP8aHyewy/lNFcOTIXhbErfviW6gF9r4udcwPevw3j
         tnAhXVNfBq9FQNdycI4P85wbJ6nCH/V4UhYRRFKz4+ijFyTB/yF9Ta+LSRzD7cBsiX9t
         GLuA==
X-Gm-Message-State: APjAAAUrdy6ckxEywyb+H9Jx9PugIwuGjl2SLOFxEJIofq7XpJKmc+BV
        RTpVOr6bD/i/70u0EKDbfM/iPB2skQ==
X-Google-Smtp-Source: APXvYqwjePq/BAwp6fXJVhzoe+ZROFTJOyS/q4V6a4m+PpeLh8276Ipx4TGFf46UvH6DIfA04TWorQ==
X-Received: by 2002:a05:6830:18ce:: with SMTP id v14mr10086768ote.36.1578959074830;
        Mon, 13 Jan 2020 15:44:34 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v14sm4704544oto.16.2020.01.13.15.44.33
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:44:34 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 223f23
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:25:51 -0600
Date:   Mon, 13 Jan 2020 17:25:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 05/17] dt-bindings: atmel-isi: add
 microchip,sam9x60-isi
Message-ID: <20200113232550.GA2344@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 10 Jan 2020 18:17:57 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-isi to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/media/atmel-isi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
