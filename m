Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99252C42B3
	for <lists+linux-can@lfdr.de>; Wed, 25 Nov 2020 16:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgKYPL2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Nov 2020 10:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbgKYPL1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2020 10:11:27 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F9C0613D4
        for <linux-can@vger.kernel.org>; Wed, 25 Nov 2020 07:11:18 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id t3so2666883pgi.11
        for <linux-can@vger.kernel.org>; Wed, 25 Nov 2020 07:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KyhPW23byefymSMyFPLZAlz2CaVmP/gApmnnW8ByLyA=;
        b=WK78I9SSLzfto+lQ8/n1esoK0m8eWc0Ba/j2zC4Tud9LakqNGjaEnpUeLtSln3ysw5
         tYGlmZU+4bDu/cA8dbf8l6OifHtzfQGObl+N+PjScDEplWq+MRLGXONsY9BJ0DzQOVvW
         z3N7ULZ41SB4Z/XzK9bKyNlOSFlRwORXn43/vH8BCvMcKtHRzNQpn/s/ggfT3QWu1qZB
         wHAjM+WLhrjG7qVZj7v/ZKMBB49FB/EoO30Hj0c6aN0cve2y5xeu7IxnCb8bSkcA99Qs
         /tj8/yx3pxcOPzzFk99mVpVjTdbGhGN/tKrOHBoWUm+0UfUvuKcqk3T+IxSQ4UWPSCVS
         x5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KyhPW23byefymSMyFPLZAlz2CaVmP/gApmnnW8ByLyA=;
        b=W+41dInflNheoSvczcSvYRoDif2+S6dFk65O05946hiDYbIgkpWlGoRahUoDw9ZULU
         /jYvjf7fEv1gEtqeUAigSEzGiRdBW3xD8/5LvM1fKUVhf+bRuM6K5thZ/oYiHaOk2MZo
         nP7h4DqDMcNadQMZMnpBkI6XuzEqdo8RFN1zEpGTEAwVKn9ZcLBjUaxtnFtxo/vazpCB
         Jf2hErlim+vLN4DZPy3zJRPX2HJDLhfR+UuL+Zi/YUhL9Zn2qf9yfjdmbD9bY/iW+kvo
         jr7N1+Wc5KSnxjgX0UEJ5isagHJbcdTgjFDuMHssofOT7OVwrrHQdrVGbYCCMy+Tad60
         klMQ==
X-Gm-Message-State: AOAM531ZqeOrXZpRv/kMjU31DWVcDgmxoIhHLs3S0RSUb4IGhyuAVu8z
        rBlUE8n1eIY38VQ/X8zeoFWN
X-Google-Smtp-Source: ABdhPJyCCNWgP2zb1NpMSNXD+2ejN6TShaPr4KA1Tb8p129z5AqP3JXvfavJFd/Mz9v4nOqaLmoapg==
X-Received: by 2002:a17:90b:e0c:: with SMTP id ge12mr4811291pjb.31.1606317077610;
        Wed, 25 Nov 2020 07:11:17 -0800 (PST)
Received: from thinkpad ([2409:4072:6d97:56c0:a022:f6b9:5738:61e3])
        by smtp.gmail.com with ESMTPSA id m7sm2405281pfh.72.2020.11.25.07.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 07:11:16 -0800 (PST)
Date:   Wed, 25 Nov 2020 20:41:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>
Subject: Re: [net-next 0/3] tef-path: reduce number of SPI core requests to
 set UINC bit
Message-ID: <20201125151111.GC20836@thinkpad>
References: <20201125145221.22241-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125145221.22241-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

Unrelated to this change, is it you or anyone working on internal
loopback support for this driver? If not, then I'll just pick up.

Thanks,
Mani

On Wed, Nov 25, 2020 at 03:52:19PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> as Thomas wants to test the rx-path improvements, here is the same idea for the
> TEF-path.
> 
> This is a short series to reduce the number SPI core requests to increment the
> UINC bit after TEF handling. This is done by chaining the individual UINC bit
> changes into a single SPI message consisting of several transfers.
> 
> I'll add proper commit messages to patch 1 and 2 later.
> 
> Happy testing,
> Marc
> 
