Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721CF373B02
	for <lists+linux-can@lfdr.de>; Wed,  5 May 2021 14:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhEEMWe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 May 2021 08:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhEEMWd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 May 2021 08:22:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A182C061574
        for <linux-can@vger.kernel.org>; Wed,  5 May 2021 05:21:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z6so1614995wrm.4
        for <linux-can@vger.kernel.org>; Wed, 05 May 2021 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5K/JBUgbItl9mJbXScIyKZb200bAuGLUE6EhA32E+d8=;
        b=Cj6xvhclGU34Bo8ps66aKYgXz8Zlf4ugmm6GXIUcx770LtQhaE3/jTLwjPyp3s9RNn
         nz+agkNofF+559wWMWMyjz4cRlnUkMvgRu46eoIxrdxu4yA623bie/pNu23md0nMEUE4
         DVnmc3WjMX0/98qcYjgjJy7SS+FClZDqsJ58XMzgeTJtROmd4moT6c76k+tLQloLb2sK
         b9xwr10TEufptuoGSyruDcLt36M+C+dHJbw005f0NOASrclkz9ze7SEyG+dHLydfcxfW
         sdyU7MfphlECtzQFEjYt3EVc2pWLUTR1Htd6GKhMdDK2tWnmoOkIi3faqUszuajQNQVO
         fD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5K/JBUgbItl9mJbXScIyKZb200bAuGLUE6EhA32E+d8=;
        b=j9of+ePq5y6AHO4Kcir7080O6kepMglYyXb59uswmDSAeEBAXNr70+1NAvXj7CiHOZ
         txoTjNlUFLtUGpO84tE22ffLvcAs0vkOKhwr3BZ73uwz8OBu4oMjRmaceaahw7GrLq9K
         WydVSKGMZvzI09Gq/6pqe07IkDJZOdsfB/CSQwahsT7vweAozX2rttdampCJLo6MlgIW
         in4jpqUGRn26hlH2bH4eZ7cicydUKM2b4NTncUHYQtTs+/R56ocaH7YpmiCXFYuOBCxO
         sFiz4Bu1zQheso88prjRgEDvpRnLIQRo+Y+7zVpDBIMifektnOiPVFZKI40XE0d6NznE
         RzRg==
X-Gm-Message-State: AOAM531MnpmuXXtxo+YKk7d1c1Qiq9PaC5vhlSV221lCi0N9XWueieRR
        nKGd8nliTPFZohMwTFYuxR6J3ozBdOKdC4BZ
X-Google-Smtp-Source: ABdhPJx5a+uyelU7ZJdxHVShrt8j2qOL1/pAyh/YrXzybHF94736jys4ChHzkWSIydM/dQzeQRvXCg==
X-Received: by 2002:adf:e510:: with SMTP id j16mr39212769wrm.28.1620217294973;
        Wed, 05 May 2021 05:21:34 -0700 (PDT)
Received: from bigthink (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id l5sm5777831wmh.0.2021.05.05.05.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:21:34 -0700 (PDT)
Date:   Wed, 5 May 2021 13:21:32 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: Improving TX for m_can peripherals
Message-ID: <20210505122132.sbutrydmu5qvggke@bigthink>
References: <20210505103049.gboat4dr3zvdm4s6@bigthink>
 <20210505115624.7qhbit4olyvpfkf4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505115624.7qhbit4olyvpfkf4@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, May 05, 2021 at 01:56:24PM +0200, Marc Kleine-Budde wrote:
> For easier queuing, get rid of the worker. Directly send the can_frame
> from the xmit handler. The problem is, you cannot sleep inside it. This
> means, you cannot use regmap(), the only thing that works is
> spi_async(). And as it's async, you can only write data via SPI, reading
> doesn't make sense.

Yeah, this makes things pretty tough, given that we currently have to
read the next available TX buffer index before doing the writes!

> Have a look at the mcp251xfd_start_xmit() function. All data structures
> for the SPI messages are prepared in beforehand in
> mcp251xfd_tx_ring_init_tx_obj(). The xmit function looks up the correct
> data structure, converts the skb to the chip's format
> mcp251xfd_tx_obj_from_skb() and then sends the data over spi. Special
> care is taken of the handling of the head and tail pointers and the
> stopping of the queue to avoid race conditions - see
> mcp251xfd_get_tx_free(), mcp251xfd_tx_busy(), netif_stop_queue(),
> netif_wake_queue().
> 
> Hope that helps,
> Marc

I'll be sure to look into it in more detail, thanks. In the meantime,
your patch is working very well to mostly solve this issue :)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

