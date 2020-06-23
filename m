Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E882052CA
	for <lists+linux-can@lfdr.de>; Tue, 23 Jun 2020 14:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbgFWMq4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Jun 2020 08:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgFWMq4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jun 2020 08:46:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA1EC061573
        for <linux-can@vger.kernel.org>; Tue, 23 Jun 2020 05:46:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so4583117pgc.5
        for <linux-can@vger.kernel.org>; Tue, 23 Jun 2020 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8zJ7vCmMVvA4Q/cR48nUwBInWGgrTlWZ4iwjeBi8X/w=;
        b=dAsTkFUJDdN2Kje23hL90ncNDtI2UalU/1UC432/JeDDlUixz9L7Y39/wcerlRhYJ9
         i11Iqga+PdynBBm6s6Hi1b2fe6m8muv9Zuao+iSACILxgcGIYiQD3VK28YkCRcgESH+m
         gzRg5H+yrb6lw6zp1TtCvWT4LD07NTNJNUhBP1G1pBzFDWB2ccn9Phg2R/376XVTsRMp
         eM1jy+p/kq5AZGOn0XXinDQP1f0ymOieF1uRYwcT4nR+RDgwNqmFCo0JRssOwSNVkFpk
         weIqIdxdquJo4/IPnAzAY1gEQtxbai4dJhU5El9frcUeHygn/Nf02cY6fgaEBfc70aB+
         V0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8zJ7vCmMVvA4Q/cR48nUwBInWGgrTlWZ4iwjeBi8X/w=;
        b=UsMyTXtOfHs7bQdKubRCvPOtZaB2lilON1ATG1dmgr3jWA49yKjWudtlkqF+mzxk/W
         se/ZoFd92CaJBUpco63CG3XG6FNTqpU/G2A4slOGzOMbCWjHlolD/4F4/mplrTPZcC4m
         d33mOwjbuq019efTZ0k4ChkoLhJbQqkYNox+DIBgeFrlVpnddLco/Oq3qs3gDmM5Q15q
         hRA2RGIGcUzahjDPmdz7lmTU+VSBPh7nXTsh1AKMBwYsmYWSFWBf8oItwVtQanekzXX1
         Pgf+nwo9ToOECaTqvCgBigDxf8xEXj0kwmcGrzWt9a56XJL/0Op4oZP/kXykvHGDnWr+
         SVzg==
X-Gm-Message-State: AOAM533Auk1AZ8ccW6F7lw4I0mLvqqHQc16ycTE6DbYXdyKR3ecstHbF
        NnvvOkkYIXgxKuDWxD89xnWbesJkaA==
X-Google-Smtp-Source: ABdhPJxLNOuUnZw6XgqtxpeZoNMVPbj1Uncr6t0PiN1d4hE9zqnvj88M1gDguwU3yKGvEFy5NXOaQA==
X-Received: by 2002:aa7:8bd0:: with SMTP id s16mr26003359pfd.80.1592916415565;
        Tue, 23 Jun 2020 05:46:55 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:609d:7d26:e4ff:f0b0:edd6:2484])
        by smtp.gmail.com with ESMTPSA id 2sm2367037pfa.110.2020.06.23.05.46.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 05:46:54 -0700 (PDT)
Date:   Tue, 23 Jun 2020 18:16:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be
Subject: Re: [PATCH v41 0/3] can: add mcp25xxfd support
Message-ID: <20200623124649.GC13669@Mani-XPS-13-9360>
References: <20200622114603.965371-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622114603.965371-1-mkl@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jun 22, 2020 at 01:46:00PM +0200, Marc Kleine-Budde wrote:
> Hello,
> 
> this series adds support for the Microchip MCP25xxFD SPI CAN controller family.
> 
> The series is available at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=mcp25xxfd-41
> 

Tested this series on an SM8250 based board connected to MCP2518FD over SPI.
Hence,

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> regards,
> Marc
> 
> 
