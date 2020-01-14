Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76DC6139E1E
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2020 01:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgANAZW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jan 2020 19:25:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37359 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgANAZV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2020 19:25:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id z64so10199533oia.4
        for <linux-can@vger.kernel.org>; Mon, 13 Jan 2020 16:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PuZkmizV0FjMntSV+5swUbzzYgbKg4dX9XcvnF9x9qQ=;
        b=ska2w644rQVMI76jxAf8QB29SaqKyYBxsaUq6fACOdEbM2xTU9GA4k1td5RG/yDy7S
         /BSzFPDNPfvXzHHoiA+lVYMWc54xIp1M8m5Ks0TCKpH0AQTtjALHMJ1zjye4P0Yx3DHH
         uq+6AG5Q5QifGDUHlkGXfe54cKxfWSOO3XPgyG4r7EDM67iYateU+Ui6TTtUN7FuB4N7
         SMHZ4CaEpw1WAbPJpP5iiNU9PUH8R5BMufgJymY+VGD5/ZVVk2CEmZowulFMKFzR+zeK
         OJazHK2GXJ1yyfh8WR1h291b1ztCw8G1Qnlu7idRB1vyRQW+bPYhE+9G3Fsd3Z6QKtXX
         i9lg==
X-Gm-Message-State: APjAAAVs/9vmjUbBBO9LWArUXLCYDhR0JVHKw17u9Dji0QD+/Y9mahU+
        C5big8xlCRCc8t3oUk5dP9xJoiq32Q==
X-Google-Smtp-Source: APXvYqzYVjvIOKR3GnJLdzYfzYzfYDlNR/44Ck0XNXYl1h6Bo2XjR4q3CQflkDUOSZljZ0dP88FtxQ==
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr15020098oij.149.1578961520606;
        Mon, 13 Jan 2020 16:25:20 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n16sm4732643otk.25.2020.01.13.16.25.19
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:25:20 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 223d55
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:17:17 -0600
Date:   Mon, 13 Jan 2020 18:17:17 -0600
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
Subject: Re: [PATCH v2 09/17] dt-bindings: atmel-sysreg: add
 microchip,sam9x60-ddramc
Message-ID: <20200114001717.GA11996@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-10-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-10-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 10 Jan 2020 18:18:01 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-ddramc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
