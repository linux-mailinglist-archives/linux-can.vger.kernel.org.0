Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE3739C41
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 11:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjFVJLj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 05:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjFVJLP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 05:11:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B284B3C3C
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 02:02:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9c0abc8b1so16415655e9.1
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 02:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687424528; x=1690016528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNA1YL50Xe6xIWLWDbv/5+owKWV0B11hHH1r7HBWhJQ=;
        b=MgwAvf6ErqDqXvFqlTHH+VdQgYRKVikpI7RfA1KVMYaNdmdGKV1HgoQ4A779PIIoX2
         ko8jojCsTVVOu3k/CwAJKJlOVq3baneWs+wurW2rUSBs1hjJQgssg2YVfztcTGRp1KFG
         ef9cf0jcppd52qYVyslcLJPJ4GFtYzN8WZBGtEnOcs06AShqefslylE8LN/AgSWp8nhT
         2u4atoEyw7zL/ckd/Fc6zfJWfkPTaFa2oL2XGFcs0sAvcK448xEZl+K5NU3XtVzbQ/6H
         B26IiSFbDZ+0b/TqHS1vN4z3ul6Dp86JAFQNsVz63muCMoHHOYPOCXY5yIso6pSQ0CsX
         LYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424528; x=1690016528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNA1YL50Xe6xIWLWDbv/5+owKWV0B11hHH1r7HBWhJQ=;
        b=OqNtWaptN6bgbPRpzm2n8FrGjZerOwqQM+dDnF3iupAv67Z61fo7Q1gC0h10gfssA7
         CuOlSkQ9rVSem4ouHwXZQhTXd0sjf3ELcAMLWFvYXx+h4rv+KWI0RgbxuQwzpHV9/2Fh
         GkCP/gH1IocsnQqzaa6i3q7aK0CwsdxmaL1wd/v48SnfvmOkY4NHqAvLX+XJVGSaO0iC
         EzLbdXAODcLkhBOSidCIEMOhbxr01KZKAXbs8OlnPK1hYgctNqa/b1CHy0HXvyJ44aP/
         HrfANCPyD6IOaBBxntY+L0rzutOXbPp5ySn36xsp6X6c+NqlHTr+i6HuvVqPRW6rUcAS
         kKww==
X-Gm-Message-State: AC+VfDyxTa55a4BxB7xJTDameYmBAXW8MSjgJgP7l6WOcf2bxY8BV3MQ
        5ImU1SQPasavIRm0UnVk9cgqoQ==
X-Google-Smtp-Source: ACHHUZ6ULGTZVS356/YkGIuUHehLy8QCjNnTymSxu6WJeiQC839ut9fvHVvZsBmjcD0sdyahKdGqNA==
X-Received: by 2002:a05:600c:3799:b0:3fa:6fc:679f with SMTP id o25-20020a05600c379900b003fa06fc679fmr1475598wmr.25.1687424528163;
        Thu, 22 Jun 2023 02:02:08 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003f9b0f640b1sm7074125wml.22.2023.06.22.02.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:02:07 -0700 (PDT)
Date:   Thu, 22 Jun 2023 11:02:06 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH v4 04/12] can: m_can: Add rx coalescing ethtool support
Message-ID: <20230622090206.qkzts2qlbqeiukhs@blmsp>
References: <20230621092350.3130866-1-msp@baylibre.com>
 <20230621092350.3130866-5-msp@baylibre.com>
 <ZJMHlIp9x8HL97qT@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJMHlIp9x8HL97qT@corigine.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Simon,

On Wed, Jun 21, 2023 at 04:22:12PM +0200, Simon Horman wrote:
> On Wed, Jun 21, 2023 at 11:23:42AM +0200, Markus Schneider-Pargmann wrote:
> 
> ...
> 
> > +static int m_can_set_coalesce(struct net_device *dev,
> > +			      struct ethtool_coalesce *ec,
> > +			      struct kernel_ethtool_coalesce *kec,
> > +			      struct netlink_ext_ack *ext_ack)
> > +{
> > +	struct m_can_classdev *cdev = netdev_priv(dev);
> > +
> > +	if (cdev->can.state != CAN_STATE_STOPPED) {
> > +		netdev_err(dev, "Device is in use, please shut it down first\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	if (ec->rx_max_coalesced_frames_irq > cdev->mcfg[MRAM_RXF0].num) {
> > +		netdev_err(dev, "rx-frames-irq %u greater than the RX FIFO %u\n",
> > +			   ec->rx_max_coalesced_frames_irq,
> > +			   cdev->mcfg[MRAM_RXF0].num);
> > +		return -EINVAL;
> > +	}
> > +	if (ec->rx_max_coalesced_frames_irq == 0 != ec->rx_coalesce_usecs_irq == 0) {
> 
> Hi Markus,
> 
> For a W=1 build GCC 12.3.0 suggests, rather forcefully, that it would like
> some more parentheses here.
> 
>  drivers/net/can/m_can/m_can.c: In function 'm_can_set_coalesce':
>  drivers/net/can/m_can/m_can.c:1978:45: warning: suggest parentheses around comparison in operand of '!=' [-Wparentheses]
>   1978 |         if (ec->rx_max_coalesced_frames_irq == 0 != ec->rx_coalesce_usecs_irq == 0) {
>        |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>  drivers/net/can/m_can/m_can.c:1978:50: warning: suggest parentheses around comparison in operand of '==' [-Wparentheses]
>   1978 |         if (ec->rx_max_coalesced_frames_irq == 0 != ec->rx_coalesce_usecs_irq == 0) {
>        |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks, yes I just changed it because checkpatch doesn't like it the
other way. I am going to change it back. Also I am wondering why clang
doesn't complain at this point.

Best,
Markus

> 
> > +		netdev_err(dev, "rx-frames-irq and rx-usecs-irq can only be set together\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
> > +	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
> > +
> > +	return 0;
> > +}
> 
> ...
