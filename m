Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A282330A05
	for <lists+linux-can@lfdr.de>; Mon,  8 Mar 2021 10:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCHJMH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Mar 2021 04:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhCHJLd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Mar 2021 04:11:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A20AC06174A
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 01:11:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so10594464wrx.4
        for <linux-can@vger.kernel.org>; Mon, 08 Mar 2021 01:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lom1WCZhRLLdmuF1G8oHHSWmmSbLzEOHdBzHWxDXsYM=;
        b=smes2I0QYZqtu1t9embCt03Hs7kqi3vHgWNEDZlRF8ZOUhxXVwJKLCoP6gKV2rExbY
         LKyhZCXf/y8UKAs9V0QatHcDk0xPpALdJKRgkXxs7pV0XgxVTLlOlHz0hS8PiW3p8F94
         30zJ5jYN0IS/2TsM1l91ZYvJjj4AIh87IPNaKSKoq5SCvVn4jEZFKqkCT/XJVkxb76hA
         mPxU2USJ/ycHsfP5Ll3/J7eCxhbOlKFBpNfeLRiWXJyM9a5MA+vEZqc63dgZKV6iWPPW
         FYf4jI2Gh6RnBdkvk56Tr7C5tQdZgCfvxq0eWCZeTs1uXlqoIEMGAEy8xVKhDuxqVFuZ
         RkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lom1WCZhRLLdmuF1G8oHHSWmmSbLzEOHdBzHWxDXsYM=;
        b=naKGcwmRtD8ch/OzIrbQ2i7imsZv8wMzNFPqbR6Ls+ALKVw2qQa7Sp1PgqT+/e80Mj
         W1W4qjstWDHEc9RQbuJO7Ay6YqIpjzvSWHpeF0mMozx/SeCPYsp0L/dcOGohNwJBs5mI
         +JF/FUB2URCF2jotl7WcjK47gH2B1P9/m/ZJjrCSgywS6z0byuMkU3hFezZES3VBmhzD
         gMAxV7cY4TNWLm4B33a1ymk3lArGZA5sld0rlu4nz8rfI9MHZu0jCxMH8JtKYoECA/jm
         WsgJjQaTb+CbaoZEfCGsgUyv6MCwASxN2M/JmIxnDWjU2VXEVMKqt9SyU+QzSMy63bzu
         030w==
X-Gm-Message-State: AOAM532IgXY5frjNQMDGXnwH2ICQFGgDFY8TsJkcMHhdgRGIZA2DVoOA
        W/fG+q1SF7KKpbc1nRTFd4d3vA==
X-Google-Smtp-Source: ABdhPJzNFC8PNPpraRTE+XaL0QLnTUtS1BdEzmzOTd3yrdERhPVthMW8wOWjaPHa2zWGuwzBs1JzXA==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr21931744wro.9.1615194692067;
        Mon, 08 Mar 2021 01:11:32 -0800 (PST)
Received: from bigthink (92.41.6.207.threembb.co.uk. [92.41.6.207])
        by smtp.gmail.com with ESMTPSA id m11sm17749671wrz.40.2021.03.08.01.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:11:31 -0800 (PST)
Date:   Mon, 8 Mar 2021 09:11:30 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Pankaj Sharma <pankj.sharma@samsung.com>
Subject: Re: [PATCH 3/3] can: m_can: fix RX path: use rx-offload to ensure
 skbs are sent from softirq context
Message-ID: <20210308091130.23736cyh7euvwxse@bigthink>
References: <20210305172015.1506525-1-torin@maxiluxsystems.com>
 <20210305172015.1506525-4-torin@maxiluxsystems.com>
 <20210305222957.elzieau5s6kbdpus@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305222957.elzieau5s6kbdpus@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Mar 05, 2021 at 11:29:57PM +0100, Marc Kleine-Budde wrote:
> On 05.03.2021 17:20:15, Torin Cooper-Bennun wrote:
> > For peripheral devices, m_can sent skbs directly from a threaded irq
> > instead of from a softirq context. This patch transitions the driver to
> > use the rx-offload helper, ensuring the skbs are sent from the correct
> > context, with h/w timestamping to ensure correct ordering.
> 
> I think you beak the non-peripheral drivers here. They already have a
> NAPI function m_can_poll(). It makes no sense and doesn't work, if you
> do the RX in NAPI and then queue to rx-offload, which then needs to run
> from NAPI again. But it cannot as m_can_poll is the NAPI function.
> 
> For peripherals it works, as you do the RX in the threaded IRQ, queue to
> rx-offload, which then schedules a NAPI, to push the CAN frames into the
> networking stack.

Understood, I will make the skb handling conditional on
cdev->is_peripheral and retain netif_receive_skb and can_get_echo_skb
usage for non-peripherals as before.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

