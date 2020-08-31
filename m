Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCAA257725
	for <lists+linux-can@lfdr.de>; Mon, 31 Aug 2020 12:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHaKKR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Aug 2020 06:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHaKKP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Aug 2020 06:10:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C8C061573
        for <linux-can@vger.kernel.org>; Mon, 31 Aug 2020 03:10:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 5so348858pgl.4
        for <linux-can@vger.kernel.org>; Mon, 31 Aug 2020 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=92VzdJE+sZsdUfKOwsECwT33k8UVZAw/YGmwth83nOU=;
        b=g2+UQ78lxADmOUQyRLNMtCoxw5I0SDDwCT9clHB3SjxI22NtJzh1GaNuPfyq+C+mKn
         gE1LyXQcZzaiO3/QWx+ShsuLFp71IBuEGsrksOYUpfCk3TCT9c+AK3/C8xEzFYljHfae
         WOPtaBFNuTa+0jl/MXHNIsgH2Hfpc9vEnKlmnLK5ALKht4nDumFgs2E42iYnA3dhprc9
         6AO/ytvV+Qu1vtsuebM9q+Wz/7j1wkZsVFDEBG6h0Y/mSsI5po88ZBuUsvvGOGS+zmpj
         XXaLb+TZ3vlLldIH1wDBVtde9g86yBI8vQkMbt8Bpjj3WU7KiqcZLsoRBlNyfK0/Kskf
         1HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=92VzdJE+sZsdUfKOwsECwT33k8UVZAw/YGmwth83nOU=;
        b=s6Tq7RdogvjkDgmEFIRWt30GBmIMdKZ56GA6C1wnPyDnhV1bc49AcODcECw56ZdcpL
         Czzy123ERyGXIHmIMZeeXxqpmuD3YBCo40YS6Gp7JFzJRl0G17V+WzvE3U++GYVAkhEC
         upqziim2V28WA3BJ4nX26G1WtC3jiXOL6LfZ1UncayFsDlwvxADZSeQmalhyP18yIkUC
         MLEwbenzNGJs15cL4yMQn660k1yJrBMuD+IXfjebFzLVTcQBeZQT/bQuD+yD7Yum8hrs
         DVSpLb47THLO+JzKV1NstU4fN9qA0Qq8OKBc8us8xZ5zw7/Nqnjk8B24i61mo8+X/YU4
         gEng==
X-Gm-Message-State: AOAM530uGf6sPqU78+ouuE6tOjDYhMCPSRZg61hRDR574GERXQpBC1vD
        NAcnf7cm0Lt75S4cIu3c++gf
X-Google-Smtp-Source: ABdhPJxp7xC38+du6bQoJJYbt/CmhN4oL/rpk4UzNuNAHNtJzwAC2t/him4N5NMZUdzJSCxDANClqA==
X-Received: by 2002:a63:29c6:: with SMTP id p189mr680897pgp.148.1598868615115;
        Mon, 31 Aug 2020 03:10:15 -0700 (PDT)
Received: from mani ([2409:4072:70f:fdfa:1d6f:524d:c4d3:917e])
        by smtp.gmail.com with ESMTPSA id 143sm7507188pfc.66.2020.08.31.03.10.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 03:10:14 -0700 (PDT)
Date:   Mon, 31 Aug 2020 15:40:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be
Subject: Re: [PATCH v41 0/3] can: add mcp25xxfd support
Message-ID: <20200831101008.GB11728@mani>
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

On 0622, Marc Kleine-Budde wrote:
> Hello,
> 
> this series adds support for the Microchip MCP25xxFD SPI CAN controller family.
> 
> The series is available at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=mcp25xxfd-41
> 

Ping! Can you please post the splitted version?

Thanks,
Mani

> regards,
> Marc
> 
> 
