Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA37A5B9E
	for <lists+linux-can@lfdr.de>; Tue, 19 Sep 2023 09:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjISHvs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Sep 2023 03:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjISHvs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Sep 2023 03:51:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3524115
        for <linux-can@vger.kernel.org>; Tue, 19 Sep 2023 00:51:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5009d4a4897so8896856e87.0
        for <linux-can@vger.kernel.org>; Tue, 19 Sep 2023 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695109900; x=1695714700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJJ+ExGDq2qJY2oh7GX6hGXNvvX2A2vHJTOyygLjZbc=;
        b=M3F1MfW96O3rq3x6pfz6sCwZx7Vl2xhdMt5/5NSbtpg99rHi0yjmGK7SuaIWQqigth
         YxbOt+/RAEfwYKbcOwF6X+12+FesDYARCKB+NmCov47lvdgJnPHi9guRl+Izfmqy4cKe
         kdBNjUMFEF73d7y5IpxW5nYUGvmsCUNAyrwg9y3sEhQTUlYfNoc1eEJlKKxzp8gQyfjp
         qdm9lJwd3qCJeDUtnLD088Vo82ScrAHEnKNc9zx+skGU72AABXCOoQEZQQqNZEhJu19Q
         7qAiOO2GXdhWuqb3PaVWe0b1Qdr8XAuGx+K7IAcIBWCipPF1FVyJfphOSFv3EMK9vPbO
         B7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695109900; x=1695714700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJJ+ExGDq2qJY2oh7GX6hGXNvvX2A2vHJTOyygLjZbc=;
        b=d0QiDn2odjhp9/SmjBthe1WIhMgZhM/dz13K1VM1Iimrg4kIstpQeBG8jUmNla/ZQr
         p5tPHyIo4dZwWa8yNOaHIiHhUxa7Kj2mA1yRFimfigwrCmJFn5EZ32jxry1OeqWZdQRt
         VfcZY7jlmPYiPg2JmQh4J++njPZOv+T3aUMRY+Ik4FL3Xu+Up4aKr4A5F014vagBMxTt
         HgytKgc0HejWG9N4OoBj4GJ0Gm+9Wp9IKB8Y4JxGZXCGGtt7Vu6yvfj2pOutdaAYs3cG
         demArHaKLZCOhSNNN9nY7oH1X3dFXAq8Mw8nCmFoupVLTTZoe5K6gu3x5Xa2TkJjgq8d
         uNNA==
X-Gm-Message-State: AOJu0YwmQyXixYsS2/WhKTGBT6ZpaTNxLMToj4uUy7nz1akj2x25yFSJ
        qe19L/gGYALUNJ3s60ZrOU/s3w==
X-Google-Smtp-Source: AGHT+IGlC4djVRlztv+UBXuAX08zNkXqe9RsFK4tYVhjdRu422bJuqs+VAB3LAmUEnlTXVQgcDLZ3A==
X-Received: by 2002:ac2:4d8b:0:b0:502:ab7b:e477 with SMTP id g11-20020ac24d8b000000b00502ab7be477mr9978897lfe.53.1695109899530;
        Tue, 19 Sep 2023 00:51:39 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id e20-20020a056402149400b0052e1783ab25sm7061842edv.70.2023.09.19.00.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 00:51:38 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:51:35 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v3 5/6] can: tcan4x5x: Add support for tcan4552/4553
Message-ID: <20230919075135.7xim2yjwt5jna4sy@blmsp>
References: <20230721135009.1120562-1-msp@baylibre.com>
 <20230721135009.1120562-6-msp@baylibre.com>
 <a94e6fc8-4f08-7877-2ba0-29b9c2780136@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a94e6fc8-4f08-7877-2ba0-29b9c2780136@seco.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Sean,

On Fri, Sep 15, 2023 at 11:36:49AM -0400, Sean Anderson wrote:
> On 7/21/23 09:50, Markus Schneider-Pargmann wrote:
> > +static const struct tcan4x5x_version_info tcan4x5x_versions[] = {
> > +	[TCAN4552] = {
> > +		.name = "4552",
> > +		.id2_register = 0x32353534,
> > +	},
> > +	[TCAN4553] = {
> > +		.name = "4553",
> > +		.id2_register = 0x32353534,
> 
> Should this be 0x33353534?

Thank you for noticing! Yes. Probably slipped through in the last
refactoring. I will send a fix.

Best,
Markus
