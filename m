Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846B324734F
	for <lists+linux-can@lfdr.de>; Mon, 17 Aug 2020 20:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbgHQSyL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Aug 2020 14:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgHQPv0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Aug 2020 11:51:26 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821AAC061389
        for <linux-can@vger.kernel.org>; Mon, 17 Aug 2020 08:51:26 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so7724025plr.7
        for <linux-can@vger.kernel.org>; Mon, 17 Aug 2020 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LxrN27i8J2SGQiEOg8NzmnxDOUrLOPaHAZLS+kOCQ1o=;
        b=z63Ofpn2j5l/nEteC9xR+PEnvI58fACgy0WUoO9g7NMqNp6pCkT0laWYxX18QjBjsh
         315kzORJosliJFj2MgJGMewssHRFFNZxpWLl81tsAOy2Mi4xdjnf+e0m38VSJyUs225S
         mVfVeNO7/GaXl8W9BNjkHwrIRboRcwAo1eM7G+7zUEF5GTY/ofX/0+3xJR5i9hvRBOvo
         dAOhyFj0b8pCUnU/JaK1U0AV85IuWDGy/2AobQ05bHfr9lR3zfidhX+BC2cU62sBdnm1
         RGwspkGm/2QSBQlOayEPerHKXfS2XnUfB55fAqOqH2wwHAWWQTxFkoW3uwWCcMeMo8KT
         bQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LxrN27i8J2SGQiEOg8NzmnxDOUrLOPaHAZLS+kOCQ1o=;
        b=qWCVciXvqaYnSV8VUiR3ZO01lUQGzbzE/PfClNO1nk5cfbwC2MF8rQwu12BgtIJf9e
         I/fBBBwZNcISoSk5jiQ28mbvkfJKOEOpz/1dsYvF7zVAHVQK4vKadrdxi3foYQxlxFsA
         RBxFaNB9VIxsAhL46RtABZDKq/n8KuxO/9pHknWxfWqmyNzTEe4RhAXVZOLpY/+DeODW
         gNY899HbgGc52fS/SH40hWbtkIf+Q+1xNu0KQD+7mKK4m5I2u8rYdkawvZxvXxg/ysu9
         cXZeZmLEg/ojFWwAYR7Z7ExrNTM4zUymRm3jIvOHXsfhbiGQdzfjphbb7sSeamaKEdNQ
         3w9g==
X-Gm-Message-State: AOAM531NcXItxEvORqIBc3h6mSoN9IwgegWTVon2RnEI8v1C9NIf69pY
        GUhKLBDpSl4170nPYvYKx367XAUSDyBz
X-Google-Smtp-Source: ABdhPJwMBnn09MRW7S3SiX0Y0s6G1M6uOIVC0GBBGrHYAL2h1zRCITwgLMA8uZqAqk31sd0qva1aXg==
X-Received: by 2002:a17:902:ead2:: with SMTP id p18mr5101698pld.259.1597679485927;
        Mon, 17 Aug 2020 08:51:25 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c99:bd61:694e:f57a:7f55:36c0])
        by smtp.gmail.com with ESMTPSA id m29sm18071105pgc.55.2020.08.17.08.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 08:51:25 -0700 (PDT)
Date:   Mon, 17 Aug 2020 21:21:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be
Subject: Re: [PATCH v41 3/3] can: mcp25xxfd: initial commit
Message-ID: <20200817155120.GA2529@Mani-XPS-13-9360>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-4-mkl@pengutronix.de>
 <20200626133243.GA8333@Mani-XPS-13-9360>
 <fdb6e441-fed5-435e-553c-1fc0a6bfb8f7@pengutronix.de>
 <20200716132800.GH3271@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716132800.GH3271@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Jul 16, 2020 at 06:58:00PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jun 26, 2020 at 04:41:53PM +0200, Marc Kleine-Budde wrote:
> > On 6/26/20 3:32 PM, Manivannan Sadhasivam wrote:
> > > On Mon, Jun 22, 2020 at 01:46:03PM +0200, Marc Kleine-Budde wrote:
> > >> This patch add support for the Microchip MCP25xxFD SPI CAN controller family.
> > >>
> > >> Pending-Tested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > >> Pending-Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > 
> > > Could you please split this patch into multiple ones? Having ~4k lines for a
> > > patch makes it difficult to review. I know that some parts are difficult to
> > > split (happened with my series as well) but anything below 1k should be fine.
> > 
> > For now I split the regmap and crc16 into one patch, the core file into a
> > separate patch.
> > 
> > See:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=mcp25xxfd-45
> > 
> > If you want to have it in smaller pieces I'll need more time to figure out a
> > sensible way to split the driver.
> > 
> 
> Can you please post the split version here so that I can do a formal review?
> 

Is there any update on the next iteration? I'd like to see this series moving
forward :)

Thanks,
Mani

> Thanks,
> Mani
> 
> > regards,
> > Marc
> > 
> > -- 
> > Pengutronix e.K.                 | Marc Kleine-Budde           |
> > Embedded Linux                   | https://www.pengutronix.de  |
> > Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
