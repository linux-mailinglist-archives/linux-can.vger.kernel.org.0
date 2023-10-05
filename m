Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B8C7BA6F1
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjJEQnW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjJEQlm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:41:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A0B4228
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 09:12:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405459d9a96so99455e9.0
        for <linux-can@vger.kernel.org>; Thu, 05 Oct 2023 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696522328; x=1697127128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r0z6lg6WCpdjTrIkK0dVsLYyVCZ/7MdG8Aqn4UL8Rc=;
        b=o681KbIh2TlLlhg8XG13gpUMzwdOWGu93tlv1/AmAQmTSR1pYFOLQ39scqoBCGGlhi
         4twWQG1uOshmLs2xF5w3/nPDQegq0pHr0IWitMDfaFoK/bDa9m+nCYE67EVozR0MX0+X
         EyGpMb4MPF9fy3rf61gcJROjNqNa6HcEqJuxmhB+ki0io7BHtCw0U0i/lw4kIKZpWQfR
         6Kjip00dYddoVNJ958TrIuB6gJsLypWAVPUE31LC1LfuJ6rivEEgPkbYFRhuBmoZQOui
         QtqcpUzWEIo2mO1rI7Z0w5A7W0peQitW15tx4IKCl23o7rV+GX/ihXN7g61y1pw7elN7
         oC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522328; x=1697127128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r0z6lg6WCpdjTrIkK0dVsLYyVCZ/7MdG8Aqn4UL8Rc=;
        b=qm0GJ0wOvoGy3RzXWcmrn8zSkZr+NPrkRHqJgsD90wqxz4nEicsJ+NdNtZJGT2o+Hs
         fNNQdrF3dfyCC3ET153++MMxJeD4x8dfTmyEdZfbIBDD9qH9gCauT68IH7JUcafJTZSS
         h7xSyWxLqFFGUsw8deBpLUa21YN8TDgblEz8ZzxM7aloqBpF2U/EF0/AixYdPYoYaMbC
         oL6xh1PIJ2GmJjdlssX+p/ztVD5pq6jlmXn1FCq1Xr38I1Pr2ypphaKUJKcu6pFZa03M
         nncZmee7lzapszOOCq7v7apUrOU921yUGwJP0sOEsTIC4SbHB75fcEw0p5UG6d9ZOXfF
         7wGQ==
X-Gm-Message-State: AOJu0YwIuYXDS7yixfaLdXW55VYgwDqVkwKw8Zl9srcAk4uzHvbykIae
        5TyQjbSk4l7ezaxMxpvqhSyzdHHINoTVXXE0bwbqeg==
X-Google-Smtp-Source: AGHT+IHsG9cALy9l/AGtf9WGqoTk1+vFPuwod1G0A2HPE9T+W6tIBWkayyF2LSEa5O28SfRy9xIMPv/xnERf3BuOFTY=
X-Received: by 2002:a05:600c:b93:b0:3fe:eb42:7ec with SMTP id
 fl19-20020a05600c0b9300b003feeb4207ecmr61696wmb.1.1696522327966; Thu, 05 Oct
 2023 09:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145150.2498-1-ansuelsmth@gmail.com> <20231003145150.2498-3-ansuelsmth@gmail.com>
In-Reply-To: <20231003145150.2498-3-ansuelsmth@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 5 Oct 2023 18:11:56 +0200
Message-ID: <CANn89iK226C-pHUJm7HKMyEtMycGC=KCA2M6kw2KJaUj0cCT6w@mail.gmail.com>
Subject: Re: [net-next PATCH v2 3/4] netdev: replace napi_reschedule with napi_schedule
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
> Now that napi_schedule return a bool, we can drop napi_reschedule that
> does the same exact function. The function comes from a very old commit
> bfe13f54f502 ("ibm_emac: Convert to use napi_struct independent of struct
> net_device") and the purpose is actually deprecated in favour of
> different logic.
>
> Convert every user of napi_reschedule to napi_schedule.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com> # ath10k
> Acked-by: Nick Child <nnac123@linux.ibm.com> # ibm
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for can/dev/rx-offload=
.c

OK, but I suspect some users of napi_reschedule() might not be race-free...

Reviewed-by: Eric Dumazet <edumazet@google.com>
