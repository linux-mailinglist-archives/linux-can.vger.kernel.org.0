Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE87BA6AB
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjJEQke (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjJEQjS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:39:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB062719
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 09:10:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso15582a12.0
        for <linux-can@vger.kernel.org>; Thu, 05 Oct 2023 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696522200; x=1697127000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRCO/tDP4lRLu2OPV/gEOu9clmIfNVaCcbX9ayRgMZQ=;
        b=sIFf5Zh2sZHqRywywGBF8so85oAW0i5GI0cfRWdSUM8jDcIuCvvr/mdR2e96GGLdfV
         Gq13bsMyuJsLjtXcYKN1HBsa5ehu+CPd/k5pv9KgHTZrdmCJrA9SjsvkYp5XjmfvQ4im
         12eztqV2Pz56UGyn/8wKmIPKtvh2SKa7FLlU+18dtVgdKlbrTrs/3E1PybeQdrvC0nVc
         oGVK1HjcgbBKi2lEbQq2QHHfSB45JcGS7qGwTh32GVgkI+TsiQfEEKyczPIOes6YgeZ3
         J5DVSgGwxfLVdZl4nP+XOYx2Ho1RU+q95bPKdLh/LqpGgHA5wW67Ym+6Oi9AC84wXiH9
         M8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522200; x=1697127000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRCO/tDP4lRLu2OPV/gEOu9clmIfNVaCcbX9ayRgMZQ=;
        b=CnJUUfG09ztHZ93L/XiRifXGmJVUT02s1ghjH/blNybiw+RIqfiL/lRexMjLixG3sY
         IJGPNhp4sgkI5AnzhcpwEwCTXkxYzmYQDDTncW9I742RpC5KS/N6zPF9fX9mPaLWwYMQ
         /CXb2C7y5gZuAt7AIGSElM/Tq9pFu6R14GuX67nJ2ngo5ogDVQvlaYtRU5M2lt0QB8sP
         D8UFaWvF+rRZ/cFjQUnV8YsiuXkzZDjPW26DYL/tisdhffEmWfZbkoteo8uTJn02F4lc
         AuiGhMmBiseO9pHt4A+CwXf9wcKKZ87avo6yZgmpCPfASW1cjtLpVHOex9b/8TBUNnbi
         NlLQ==
X-Gm-Message-State: AOJu0YyBoEJu3GKYAXKLLErymj+PTmyAC2Ox26hr2MLN43EHmKTGQwsr
        HINlntZV8nkFzVe8pOc30El97qiqjO1RdNWswqKIRg==
X-Google-Smtp-Source: AGHT+IFzYlK6nOXqFn3XTRyZ9yDEZC9Bs5FeKRJ0Zfr3978r7XwjxquujorP05hjLrjSFu1gUI2ea386eAkHyH3Ha+s=
X-Received: by 2002:a50:8d0f:0:b0:538:50e4:5446 with SMTP id
 s15-20020a508d0f000000b0053850e45446mr71813eds.5.1696522199600; Thu, 05 Oct
 2023 09:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145150.2498-1-ansuelsmth@gmail.com>
In-Reply-To: <20231003145150.2498-1-ansuelsmth@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 5 Oct 2023 18:09:42 +0200
Message-ID: <CANn89iK5E=SFJoNNTd3SNdT0oPR503dEf_gNfP=Ls3AKS_4F_g@mail.gmail.com>
Subject: Re: [net-next PATCH v2 1/4] netdev: replace simple
 napi_schedule_prep/__napi_schedule to napi_schedule
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chris Snook <chris.snook@gmail.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Douglas Miller <dougmill@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nick Child <nnac123@linux.ibm.com>,
        Haren Myneni <haren@linux.ibm.com>,
        Rick Lindsley <ricklind@linux.ibm.com>,
        Dany Madden <danymadden@us.ibm.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
        Ziwei Xiao <ziweixiao@google.com>,
        Rushil Gupta <rushilg@google.com>,
        Coco Li <lixiaoyan@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Junfeng Guo <junfeng.guo@intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yuri Karpov <YKarpov@ispras.ru>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Lee Jones <lee@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Oct 3, 2023 at 8:36=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> Replace drivers that still use napi_schedule_prep/__napi_schedule
> with napi_schedule helper as it does the same exact check and call.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
