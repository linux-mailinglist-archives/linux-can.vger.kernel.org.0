Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BB1739BBB
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 11:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjFVJDa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 05:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjFVJCz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 05:02:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA56344BE
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:57:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f9002a1a39so51869405e9.2
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687424219; x=1690016219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYj0kF+dzS7Q/arinZBG6xHJRLpIjG9vQ6Zf+0/OOSQ=;
        b=FZnk0yJ71U5DnQbfP28oCPGQyT0mmpqmgxF1WkUwAxhJKZ1BxhZdst7m6FDF/JLy4k
         CxAdBbm9DFVSkDIE9Bz1zqpiCsaxJvV7VzieXRmelcqZEAb8wLesSRlFWmeyyNCZTm5E
         qDif96BK91BGs9YHNe3IINjdghRd/1jsa7nkot10rIAxg6wB6SGCw4NBegsC8ttpdR/Z
         2W4fbSkPxCysAVcOYq2GHH38dYYTxYQzwDBnMfKwfOWmLo2Di7EQXV5nlao5wPqmOrFe
         jQ1GCJhUvqFTCe3z47gUb4gvDBDkgjvLZLORCljlg31i5KrsGA2pIZKMcnSdcTYJaHX9
         S67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424219; x=1690016219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYj0kF+dzS7Q/arinZBG6xHJRLpIjG9vQ6Zf+0/OOSQ=;
        b=XV8d2srGnWHhs2Ac2On+6c/EkfioAIR4tCENqwDvWQ2eJEouxALfY1JD+W7lV60iHX
         V+rKKfnClzJVy2Ge1TlKjNRmM71uMF9xihnHUF+CYsmbyRBQgBdCT17JZepGb+vzdBPN
         dN0hwm3UIUF89leWLeOpkDvayLtojFWXA/+ox9JlWCV8KWtTcx5ZV2+IjL0s8Jj19kwp
         aTi+kkeH1dxvg4Ll4jzbhJAmGBi5zAD+UcwMYMBfiII1hAfA9dq7Mczb9pdd0MXmWLN5
         ej0McWhvjZizqocumQj8p+r2hdmQAh4BxU3VgDYOsdVngFmtwJAmPS/+EFPDBL5jxGfa
         NPtw==
X-Gm-Message-State: AC+VfDxP856nZJrQmXESOeI5KqAFxXJNC+iHXYCM00DQFPx4PeOKimWm
        Eo7VBMpzzc2InAqNHaCRE4cBiw==
X-Google-Smtp-Source: ACHHUZ5XUwN85tvVpsZBM9MADVUC/SI44IDFneKsdbwyh8VKPvu5/Ni1+DY9dbECRsGDLrgjBrGVHg==
X-Received: by 2002:a7b:cbd3:0:b0:3f9:b3ec:35d0 with SMTP id n19-20020a7bcbd3000000b003f9b3ec35d0mr6334592wmi.10.1687424218783;
        Thu, 22 Jun 2023 01:56:58 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003fa740ef99esm961316wmq.45.2023.06.22.01.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:56:58 -0700 (PDT)
Date:   Thu, 22 Jun 2023 10:56:57 +0200
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
Subject: Re: [PATCH v4 01/12] can: m_can: Write transmit header and data in
 one transaction
Message-ID: <20230622085657.agfk5jee3azdwqur@blmsp>
References: <20230621092350.3130866-1-msp@baylibre.com>
 <20230621092350.3130866-2-msp@baylibre.com>
 <ZJMG2ovqLXjMjgZg@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJMG2ovqLXjMjgZg@corigine.com>
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

On Wed, Jun 21, 2023 at 04:19:06PM +0200, Simon Horman wrote:
> On Wed, Jun 21, 2023 at 11:23:39AM +0200, Markus Schneider-Pargmann wrote:
> > Combine header and data before writing to the transmit fifo to reduce
> > the overhead for peripheral chips.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  drivers/net/can/m_can/m_can.c | 34 +++++++++++++++++++++-------------
> >  1 file changed, 21 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> > index a5003435802b..5251073987ee 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -317,6 +317,12 @@ struct id_and_dlc {
> >  	u32 dlc;
> >  };
> >  
> > +struct m_can_fifo_element {
> > +	u32 id;
> > +	u32 dlc;
> > +	u8 data[CANFD_MAX_DLEN];
> > +};
> > +
> >  static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
> >  {
> >  	return cdev->ops->read_reg(cdev, reg);
> > @@ -1622,6 +1628,8 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
> >  static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
> >  {
> >  	struct canfd_frame *cf = (struct canfd_frame *)cdev->tx_skb->data;
> > +	u8 len_padded = DIV_ROUND_UP(cf->len, 4);
> > +	struct m_can_fifo_element fifo_element;
> >  	struct net_device *dev = cdev->net;
> >  	struct sk_buff *skb = cdev->tx_skb;
> >  	struct id_and_dlc fifo_header;
> 
> Hi Markus,
> 
> GCC 12.3.0 complains that fifo_header is not (no longer) used.
> 
>  drivers/net/can/m_can/m_can.c:1635:20: warning: unused variable 'fifo_header' [-Wunused-variable]
>          struct id_and_dlc fifo_header;

Yes, I moved everything to fifo_element on purpose and then forgot to
remove fifo_header. Removing it now.

Thanks,
Markus

> 
> -- 
> pw-bot: changes-requested
> 
