Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99CA373BA9
	for <lists+linux-can@lfdr.de>; Wed,  5 May 2021 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhEEMrP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 May 2021 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhEEMrO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 May 2021 08:47:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DDEC061574
        for <linux-can@vger.kernel.org>; Wed,  5 May 2021 05:46:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y124-20020a1c32820000b029010c93864955so3339791wmy.5
        for <linux-can@vger.kernel.org>; Wed, 05 May 2021 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h2NT3EAhxisnTUN+6uxmT5lE+Nyhd1P4grGMe6EQ8hU=;
        b=pDv2xdRDsSXyhQ2lE/9JzZm5irRhdvrLRGnYA4sRINCV7A+f0/s+nUt0wiawqiHgK4
         rfaKI6Pi11z/6hNgP5wXgTxwuc5hsTL3obmsDW3FEF9VvUPpYAkyH3aCKQfSp11OuP9R
         4fybP3LlpkkdpRdGDMoUXmhgHB3dAdX3b6ZFEg7t6/Sut1ryBF7jmknWuUxSdqkXMBFf
         4rPDkiI/Zku2Lc3wF/noW5n9l2ptIOmthLygXlEChL7v6hb6dHEN4Skz1SbIa0dp3+t+
         HnOQaPAJGV7orxDtbkYTwDWGzU/a0PdWCnKLfhVSZEMdOlpw8PSAFfRAcywHx2/LXn7/
         4Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h2NT3EAhxisnTUN+6uxmT5lE+Nyhd1P4grGMe6EQ8hU=;
        b=soa3joqsX4ZtO3XZ78cERKyHHAPFLl80prXvBsaTz3Jipu7ANQk3vCJDYu8qrEoiOZ
         AZGLKSiIsYkz0YUXlXyY2jFVgSfwR6p/N13CIcq5TDa+GU4KVadaWLkSdLNoOaMzqaq3
         lC6zydg7K9SCyKVDW4PhqL9HjIDq6QNDnRU+RNEvKHqOkYlgankjdIyCBe3eIww3drcZ
         IcXo8NbV8tgynZUy/pSKrCl35CijY97tR/Qi8MLk818QhMi+Rhq9WLSbOLUg6jteZ2zA
         hFodB0gKMlWsiuq8L74/pXs2LExy66wq0k0OpVmwmPPykBNbDc7cuEOcx4iBn88dAd6V
         0AHQ==
X-Gm-Message-State: AOAM5337zvh2GogIbgPTGkRQcsESiEZNXViwhT49HKm2lgjuQMZCJAKU
        Qh4liE5XpdhnqaV+34FFd1qWyMSsbwVmr85x
X-Google-Smtp-Source: ABdhPJwXWQIh62F9L8PaBJp2XzsVuXQ892CcPKb7Wal083KQg7vg/FGMXegMkVG/L5VDHu/XPk1p0g==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr9946293wml.146.1620218776517;
        Wed, 05 May 2021 05:46:16 -0700 (PDT)
Received: from bigthink (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id 61sm21099062wrm.52.2021.05.05.05.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:46:16 -0700 (PDT)
Date:   Wed, 5 May 2021 13:46:14 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC] can: m_can: m_can_tx_work_queue(): fix tx_skb race
 condition
Message-ID: <20210505124614.x2mdkoozvftzynuo@bigthink>
References: <20210505114302.1241971-1-mkl@pengutronix.de>
 <20210505120659.bconnblkp5lhd52t@bigthink>
 <20210505123501.np5f2xbx4jwkalv6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505123501.np5f2xbx4jwkalv6@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, May 05, 2021 at 02:35:01PM +0200, Marc Kleine-Budde wrote:
> > Thanks a lot for spotting this Marc, after initial testing this is
> > working very well. I don't see that error message at all now, even at
> > very high transmit rates, and dropped frames are reduced considerably.
> > 
> > (Test setup: RPi CM4, TCAN4550, 500 kbit/s CAN-FD.)
> 
> Can I add your Tested-by?
> 
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

Yes, please do!

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

