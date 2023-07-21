Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28B75C7EE
	for <lists+linux-can@lfdr.de>; Fri, 21 Jul 2023 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjGUNhH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 21 Jul 2023 09:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjGUNhG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 21 Jul 2023 09:37:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAAA1986
        for <linux-can@vger.kernel.org>; Fri, 21 Jul 2023 06:37:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-316f9abf204so1669292f8f.1
        for <linux-can@vger.kernel.org>; Fri, 21 Jul 2023 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689946622; x=1690551422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cyJTSHbeo76bzi6vElx+C7cII9lsbnhay7widihGytw=;
        b=zk1Ag3uPbpvIF+OjujPgm2Lry426dUcuFeJkaainc672cQ0u2V88zlLAKFj+30H1nv
         nCvnihrj0cNimAIROEjqxQRYg59jmE+e9f67u5bzXhAKqp9Wp2wsmqtEFbHhMW49vMiB
         lm73FUZFhW0c8HNVJQBZ836nxN+Ho1Ufh8x99SHaU5HKr0kxAIqKMLwv2K7Jr+0R2VDG
         BWrMOb5aR9dErBy0t20aCrE16oY8fugS/3x8L+2zzSvJduYbu6wRtMm38WWk8FjynLlw
         hrr2HdsJ33A/M8QCy7jaiETViUviVie+KrsFfb7T9HsyRctOQ+Jm0IarejMT5zNVBqjE
         Ue3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689946622; x=1690551422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyJTSHbeo76bzi6vElx+C7cII9lsbnhay7widihGytw=;
        b=jkmGUbwF8cZukpPC4C8n4DT7aePW8FbgXRCbswrdc+J+gSLg+nRrCpCXqIcuZFgRyq
         ClhQsgf7NuOv30gNAYhqazKGaMPN2v5DEY2Czcs240NOINSnVxFhkL/yPOmaAI13S4/H
         zTFdkdZu+GPRfki4TS4Ax0DzDqvMQAPRXZ8Te09LPeFNTbK3pwhssevepkkrRvWQfGg6
         1n2U2eDpjX3K3C52mBx5D3OY72D4gijBMglS7TwOlHvAj411iknG1PUkhUO51yx9YB3r
         hD2dc6ssGs4TPLVbyJWpFEXzpv09bJtgJ0CZCnHEbynSX+C/0vnVjEnSFOHrv6Kq/WyZ
         2DAg==
X-Gm-Message-State: ABy/qLaaubNhqMyOWZp4PBHyq3FvYwn+mlRhqep08Cvc05EjE1aJV1+1
        LvCnUP0mWhjlE+Vd3vPg60zCO7CDP+HchBl2HC4=
X-Google-Smtp-Source: APBJJlEamjH4SEwBOa7+/tDkX8IYcdS8z1RSOIETUrQMKtwEUtTm4XVENZbQn6tjOW7nZ1WOZ+STig==
X-Received: by 2002:adf:fed2:0:b0:315:8f4f:81b8 with SMTP id q18-20020adffed2000000b003158f4f81b8mr1501101wrs.50.1689946622331;
        Fri, 21 Jul 2023 06:37:02 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id v11-20020a1cf70b000000b003fbacc853ccsm3412568wmh.18.2023.07.21.06.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:37:01 -0700 (PDT)
Date:   Fri, 21 Jul 2023 15:37:00 +0200
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
Subject: Re: [PATCH v5 12/12] can: m_can: Implement transmit submission
 coalescing
Message-ID: <20230721133603.eahybmvzf4yalyn7@blmsp>
References: <20230718075708.958094-1-msp@baylibre.com>
 <20230718075708.958094-13-msp@baylibre.com>
 <ZLlZudoYyarYmEjz@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZLlZudoYyarYmEjz@corigine.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Simon,

On Thu, Jul 20, 2023 at 04:58:49PM +0100, Simon Horman wrote:
> On Tue, Jul 18, 2023 at 09:57:08AM +0200, Markus Schneider-Pargmann wrote:
> > m_can supports submitting multiple transmits with one register write.
> > This is an interesting option to reduce the number of SPI transfers for
> > peripheral chips.
> > 
> > The m_can_tx_op is extended with a bool that signals if it is the last
> > transmission and the submit should be executed immediately.
> > 
> > The worker then writes the skb to the FIFO and submits it only if the
> > submit bool is set. If it isn't set, the worker will write the next skb
> > which is waiting in the workqueue to the FIFO, etc.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Thank you for your reviews!

Best,
Markus
