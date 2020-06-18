Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42A1FF135
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2020 14:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgFRMG1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Jun 2020 08:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgFRMGY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Jun 2020 08:06:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B893DC06174E
        for <linux-can@vger.kernel.org>; Thu, 18 Jun 2020 05:06:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so2819204pgn.7
        for <linux-can@vger.kernel.org>; Thu, 18 Jun 2020 05:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KnZMcd7hAByohLFNqoZ+jn6S/xUHmJ274kiUVqsCRiY=;
        b=i3r8xzakfwZ3uk+CMdQ56vr7b6YalR5xVqKnNsXOUACwqn6g/kFD9NV2DtKAsfwJaV
         dTBC6UOcltvDhwyOleA9nXDGIpHOG2RlCrdWU15Ljr1IGgxp9QnrdR1DY0w5foaTbGfH
         2quSvqHaIzhOkFQBInGA1Qq04L+fJpUrRRnKhuk34E2+hhPa3RFn1/kFZfxUTtvqUWOq
         YSZIcjsh2KErBcDAtrH01Ak3g7V8H3xn3tabJBhESZWrFZJFu1qqF5y7Ar4pHQL8gTJ8
         roE5u9XlqcQxRP2KBd75xfWgYdqYVZdKr+71OZxiKcjPxRF1BcFDndGlXizFJEmaxt1n
         UW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KnZMcd7hAByohLFNqoZ+jn6S/xUHmJ274kiUVqsCRiY=;
        b=rqXYLyH17BbsBGZcPNiwiG/R0op84jVQgA6oAP+Lz6vgFBp+iPRBo8RgLs5E4xJ2+l
         Vri5tmTfHLhe2XWj9L/Ik3PNd6bkJ8iPgYTXjYQQnBzI6A1U3A4CGz+NFnWHFMYB7Wwv
         bzaOpHvnRqXOEJwTo/qiShBba9+mpTLJKJR5Q6H+cjxs89MpL1EoX6AjkvA4T1OzfcAh
         +rh4NGGiEr+LeFdPTvC1k8ZdvmLD91vVZmNAqmRQYGpQCD5djhdW1yiax5GyygiRcFAW
         NmZ/hhZ789vVtP0c9z+z2UJk3MySk5UbnSQ0k/x7mufvZF23X0abQVU+4x/2oypaDZXX
         Jpgw==
X-Gm-Message-State: AOAM530cDXbG8QJgaXGHXoa+TeQa78xewNWSjMv+ofFIxyF/KW6Rkrc8
        9UKpp79ZQYgHRFIgG/hZb7p8
X-Google-Smtp-Source: ABdhPJy6Et0T3fLfK70E25pbBoRMbq0GcwLBqfDU7X9MU0HLviPALhHwAj1hlrzRqKkBMR3NCwhJ4A==
X-Received: by 2002:a63:1007:: with SMTP id f7mr3016539pgl.147.1592481983117;
        Thu, 18 Jun 2020 05:06:23 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id i22sm2780776pfo.92.2020.06.18.05.06.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jun 2020 05:06:22 -0700 (PDT)
Date:   Thu, 18 Jun 2020 17:36:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     wg@grandegger.com, kernel@martin.sperl.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Message-ID: <20200618120615.GA3949@mani>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
 <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On 0611, Marc Kleine-Budde wrote:
> On 6/10/20 9:44 AM, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds CAN network driver support for Microchip MCP25XXFD CAN
> > Controller with MCP2517FD as the target controller version. This series is
> > mostly inspired (or taken) from the previous iterations posted by Martin Sperl.
> > I've trimmed down the parts which are not necessary for the initial version
> > to ease review. Still the series is relatively huge but I hope to get some
> > reviews (post -rcX ofc!).
> > 
> > Link to the origial series posted by Martin:
> > https://www.spinics.net/lists/devicetree/msg284462.html
> > 
> > I've not changed the functionality much but done some considerable amount of
> > cleanups and also preserved the authorship of Martin for all the patches he has
> > posted earlier. This series has been tested on 96Boards RB3 platform by myself
> > and Martin has tested the previous version on Rpi3 with external MCP2517FD
> > controller.
> 
> I initially started looking at Martin's driver and it was not using several
> modern CAN driver infrastructures. I then posted some cleanup patches but Martin
> was not working on the driver any more. Then I decided to rewrite the driver,
> that is the one I'm hoping to mainline soon.
> 
> Can you give it a try?
> 
> https://github.com/marckleinebudde/linux/commits/v5.6-rpi/mcp25xxfd-20200607-41
> 

Tested this version on my board with MCP2518FD and it works fine. I'm okay with
moving forward with your version and would like to contribute. Please let me
know how we can move forward.

Thanks,
Mani

> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
