Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCAF139E25
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2020 01:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgANAZe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jan 2020 19:25:34 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37245 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgANAZe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2020 19:25:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so10882883otn.4
        for <linux-can@vger.kernel.org>; Mon, 13 Jan 2020 16:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2uIWxQRw2ac2zDhobeFtImF06Kett0ywn6nB0mPlAo=;
        b=udIyYF/jfg1PGuMRSA/4V35pvhDqmi+vleYV2vBkYpL5GI9cTTdj53BwNacvsJ5yyO
         /adVerLVuRFQLw+S6487yt9RydVwT9SqZLUY88DYHZXoo2QAdtSe2AHErzgSuvK2e61d
         J850bAu3F//Zs4SKUhGOjHPkAF9FE2ZEDEkFJJH/x3febtjTzgtJmTXGugvlJkpNfmMj
         xeLiKm/g/DvBeTKNoDnLrf4dUTiWvirUu8qA5+J4+72cgtzNN9gdx16aKr1niJHFEGoG
         C2F9IC3POk33SEPEdTYYnoua9LnaZygci8Ve5mUPWGQwWRiwJG774PpnQ2MWF3QU86Jm
         2J/A==
X-Gm-Message-State: APjAAAWWP6KQClCIrRIiq+uMdeF+jodvfDs4+w5gK+blqnG5Yvuij3Jr
        eSGDadUBAUuBFIzr69HpzSjSsJR3Kg==
X-Google-Smtp-Source: APXvYqx6sv/yAlaI3Dx0xkGLV/qWiv4HsOLN/x3W/mNaUXlKH8cY3NmnvPfJPHWm6JFeo8EyvljFwA==
X-Received: by 2002:a9d:588d:: with SMTP id x13mr14188927otg.6.1578961533275;
        Mon, 13 Jan 2020 16:25:33 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d11sm4745543otl.20.2020.01.13.16.25.32
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:25:32 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221ab2
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:16:59 -0600
Date:   Mon, 13 Jan 2020 18:16:59 -0600
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
Subject: Re: [PATCH v2 08/17] dt-bindings: atmel-nand: add
 microchip,sam9x60-pmecc
Message-ID: <20200114001659.GA11452@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-9-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-9-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 10 Jan 2020 18:18:00 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-pmecc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mtd/atmel-nand.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
