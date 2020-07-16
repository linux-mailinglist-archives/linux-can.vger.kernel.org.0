Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D912223E2
	for <lists+linux-can@lfdr.de>; Thu, 16 Jul 2020 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgGPN2G (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 Jul 2020 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPN2F (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Jul 2020 09:28:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8155DC061755
        for <linux-can@vger.kernel.org>; Thu, 16 Jul 2020 06:28:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g67so4849675pgc.8
        for <linux-can@vger.kernel.org>; Thu, 16 Jul 2020 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vc0XG96BvbiF/MlmAlWNTIUm8/yllvXsoquvLd0rLx0=;
        b=hscGMh0zQk/PJL+F64Zi9EtF6jdh8V7z1Z6g243nBmlKIteityhvMVkkVB6w4nbJHN
         9gJn9qyP/U35AiOIuwdlwAXtWlYMxCsSU3d2Udgcf4l8P+XORpYgb5cbZUH0RjX9tff9
         +75MTXK3BQ/oG8PpvyfbHhxA8plN/T2QoHyWSWksnmfVV2yzbYyNlsY9ZV9TkA8EDJvm
         AUQ3V4e9rhKAON+mUui+Vr7pWpO4shgxl+xQH/T2DJL2qucQxHMOjnWtoU78peSsKTsx
         kRbzIlUc5Omc6RZHwvEJvMb0LVYl98CGjBhujRbDCLMQyFsAeoONTKf0uXHo8WLUjSl9
         rj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vc0XG96BvbiF/MlmAlWNTIUm8/yllvXsoquvLd0rLx0=;
        b=UhMzM3xWhcusLuRUeB6rLbS+N8qG/F/BP8scycvmOcZ3bzQWaqbw2TmN3Fbd5LMsN/
         yxauRM+d0Xp+i2fpoKwQkibixHU5xlxxFCNpwUXM86hyjd8MkgluQBG+I5y1oZV8B/Ws
         FkvlDU3frv9CEac9flCE58wxtzSmey48hdxq8k3dB5HiTYmzbmOh0TXkp5FxQgd7tV/A
         a2ygFtfv4roFz0K22bSCanPGOXXUPyBendeZClL8f3JiVwK6Zf6GkhLw3ZVswtpMAAoh
         L76am0pWfRidImWloJ2lFRQHBX0AQ9nDnXm64oGKPaFK3+uZuQBloABzqIXhCYgxZbMQ
         iCYA==
X-Gm-Message-State: AOAM532TXuNsFkHRZOp3IDUUmXP30KEo+TcmZr0rvMY2JOODDOlcL+1q
        FtU0mcMUj/XY/Q/HpmeZN+5F
X-Google-Smtp-Source: ABdhPJw0q2N6M5eoNqvGYZAQ9p+BUCJd18RghLoeuxft4gJ3u3dGL5TpL16tp9J30iTw3Yd+GaRsmw==
X-Received: by 2002:aa7:9909:: with SMTP id z9mr3546515pff.139.1594906084833;
        Thu, 16 Jul 2020 06:28:04 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:494:2704:9157:c271:c363:4849])
        by smtp.gmail.com with ESMTPSA id a2sm5047236pfg.120.2020.07.16.06.28.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jul 2020 06:28:03 -0700 (PDT)
Date:   Thu, 16 Jul 2020 18:58:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be
Subject: Re: [PATCH v41 3/3] can: mcp25xxfd: initial commit
Message-ID: <20200716132800.GH3271@Mani-XPS-13-9360>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-4-mkl@pengutronix.de>
 <20200626133243.GA8333@Mani-XPS-13-9360>
 <fdb6e441-fed5-435e-553c-1fc0a6bfb8f7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdb6e441-fed5-435e-553c-1fc0a6bfb8f7@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Jun 26, 2020 at 04:41:53PM +0200, Marc Kleine-Budde wrote:
> On 6/26/20 3:32 PM, Manivannan Sadhasivam wrote:
> > On Mon, Jun 22, 2020 at 01:46:03PM +0200, Marc Kleine-Budde wrote:
> >> This patch add support for the Microchip MCP25xxFD SPI CAN controller family.
> >>
> >> Pending-Tested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> >> Pending-Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > Could you please split this patch into multiple ones? Having ~4k lines for a
> > patch makes it difficult to review. I know that some parts are difficult to
> > split (happened with my series as well) but anything below 1k should be fine.
> 
> For now I split the regmap and crc16 into one patch, the core file into a
> separate patch.
> 
> See:
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=mcp25xxfd-45
> 
> If you want to have it in smaller pieces I'll need more time to figure out a
> sensible way to split the driver.
> 

Can you please post the split version here so that I can do a formal review?

Thanks,
Mani

> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
