Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004E27577FB
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjGRJ2I (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjGRJ2G (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 05:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808F2E69
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689672437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0vyMeOfw7fSC/qxKnZBBj+xlz8lL8pZMksMNnnuzCg=;
        b=Q2+7fGF0YkjJPjxBfiXUIFkyFK5IRcBIC8/xhlL+kpaCbfiCSxwWapD7JXhNS7srOtvUqS
        idSrC9/xzjOeMZ/M8q6XgyTv9hMgFnvyY/sllrd8LeFgIm4k5nuBQ93iP4SiKvPFB6UUz+
        ZN478OsyWDXLgMv7hDKdnoKQ5HpMCPE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-1QQ5EVTCMFiLkaMkspHg9w-1; Tue, 18 Jul 2023 05:27:16 -0400
X-MC-Unique: 1QQ5EVTCMFiLkaMkspHg9w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635eb5b04e1so13842186d6.1
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 02:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689672436; x=1690277236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0vyMeOfw7fSC/qxKnZBBj+xlz8lL8pZMksMNnnuzCg=;
        b=iEmiDiHqLpvvHEP/sogT3Fl0BvW91JYiYMjLc7NTntM7FTsW0gE6jOCZ/IodZHWqQR
         rFk013czanryPljzM+dWKC+GnhnysNcpalMK4uolRsPBhyNjFACoGdPRuFm1bvg1AYbp
         36bPIkAScAaYTPf9u/isKNhuU1LRYCEh8ZnXNGZxdsOoaYgOjEmSfRkNZPQJbFarDF4Y
         6sBJEoAcb2DlWzzAMpXiJgSxIkToehHLbzhkuhV9Ruz7/SHHPriU6OVxwxGoDWminTaM
         LFS/uoK85Lfg+pAhT+Tv9kmXFXhKK4mNo3kMRQTqsonKYYpUiVTbYhruZutp89OFEbGS
         czew==
X-Gm-Message-State: ABy/qLaVOW6cZx1COLvK7MclMRo4pcq5LifTZcFHiE5INSrDpWwux7BM
        smEVNNcz2EaugiGePKutAjS34NlsAoY++qQXXko7mRyrXh9r0nobdMrAFVTjtoPlv3kdaL8ENbG
        sS2GAkOqRdI1pFPLgGp/x
X-Received: by 2002:a05:6214:509d:b0:63c:7427:e7e9 with SMTP id kk29-20020a056214509d00b0063c7427e7e9mr12261342qvb.6.1689672436179;
        Tue, 18 Jul 2023 02:27:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFYFNw7x3jThmvZICEe6iXFu0qG+zQql7vEpRKMvc0qVPxJUK7o8zW+ji84Z85dUEkIw+qD2g==
X-Received: by 2002:a05:6214:509d:b0:63c:7427:e7e9 with SMTP id kk29-20020a056214509d00b0063c7427e7e9mr12261327qvb.6.1689672435965;
        Tue, 18 Jul 2023 02:27:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id h10-20020a0cf20a000000b00635fc10afd6sm592785qvk.70.2023.07.18.02.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 02:27:15 -0700 (PDT)
Message-ID: <ee31215ededd386eba19fb62b0de8d0bad78d687.camel@redhat.com>
Subject: Re: [PATCH] net: Explicitly include correct DT includes
From:   Paolo Abeni <pabeni@redhat.com>
To:     Alex Elder <elder@ieee.org>, Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-amlogic@lists.infradead.org, linux-oxnas@groups.io,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-wpan@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        wcn36xx@lists.infradead.org
Date:   Tue, 18 Jul 2023 11:27:10 +0200
In-Reply-To: <1c6175fc-496a-843c-c8c5-2173e065eaa8@ieee.org>
References: <20230714174809.4060885-1-robh@kernel.org>
         <1c6175fc-496a-843c-c8c5-2173e065eaa8@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On Sat, 2023-07-15 at 10:11 -0500, Alex Elder wrote:
> On 7/14/23 12:48 PM, Rob Herring wrote:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >=20
> > Signed-off-by: Rob Herring <robh@kernel.org>
>=20
> (I significantly reduced the addressee list to permit the message
> to be sent.)
>=20
> For "drivers/net/ipa/ipa_main.c":
>=20
> Acked-by: Alex Elder <elder@linaro.org>

The patch does not apply cleanly to net-next. Rob, could you please re-
spin it? While at that, have you considered splitting it in a few
smaller patches (e.g. can, dsa, freescale, ibm, marvel, mediatek,
stmmicro,  sun, ti, xilinx, wireless, remaining)?

Thanks!

Paolo

