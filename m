Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813C77B6052
	for <lists+linux-can@lfdr.de>; Tue,  3 Oct 2023 07:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjJCFWE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Oct 2023 01:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjJCFWD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Oct 2023 01:22:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A44B0
        for <linux-can@vger.kernel.org>; Mon,  2 Oct 2023 22:21:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso8159a12.0
        for <linux-can@vger.kernel.org>; Mon, 02 Oct 2023 22:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696310518; x=1696915318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqpR6B8+nR6pcymfGZfMhsWiKXO7OC+lMbowiW4LVxc=;
        b=UaBLzEzVytEjZbXxfZJ/yKqhK1RZp492+FSmCuOa7ivIYhUjuF8hhU9LAqmzdU4w6t
         ul2WUkeUtwkfafuUvtV5ho6mCBWCD1BhiuFT3QHzF9AgAZincFasUEejf8VNCz3bzWlf
         GcEipmR4Vx/LRl/d6L2tGAtJhsSmlAtgXdQ+lecGw4omrkwjLD213+u2cjhh74VBEOOo
         QIO1M7y3isPpmNsFx+OBLYxufeYEl8tgPqr0eoUNHY5EkFk9sRSqyWRRUootS4hdLrMg
         dMK2ipfmJzdEbgC5gFllURR7gNvSbIldfQxtXeVgoX8FZYliPEHedY71EL84X+SlgOTP
         vjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696310518; x=1696915318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqpR6B8+nR6pcymfGZfMhsWiKXO7OC+lMbowiW4LVxc=;
        b=Ma5Fa0XumLF006Ub9+0pDidy2oG69vtUtIjHOEzkvMeoc1ByytNDD5CPRYiiyB7L2m
         jzGu72IxYARL6lYu36EnvZgApeLpBwjoGcNH3G/8GYsz2su4EJekYdfek1ZZn3FncfrX
         1e3ntX9DiNtof3gpC9n/DzGkRVZc6WfJhLTFB7tweFrpX/hzwkduFFkwLF2hnhDU30/H
         jfCLYvWzwhNKgBLTFaTXpcLeHIhCbMKrw6dE3ezaCHLKXLcgVUSX8DJUCLoq0jcy9ZRs
         yfPZi7smx2WSI/j4L4gAS9+9t9Yzsa6opv7sz4erVVYMp4SDOHXINyKoYe/5CBGVhHJq
         H75A==
X-Gm-Message-State: AOJu0Yy8sB714nm3TWfhZp2Mq0gThJfxPhXBkz25aY9bDJFmGMXe4O95
        8pwMXFF1SZhHdFg69FXU2IL8rrOB5eY4as9b5OAgRA==
X-Google-Smtp-Source: AGHT+IFKI0HKrYVLDl5vmsJpfAS1RFLGp2hw35YvLJzj9lzKha+Fza93n9nqgIQgLugkI+eoDblKihBS9oaXtRjP+8s=
X-Received: by 2002:a50:d4d7:0:b0:538:1d3b:172f with SMTP id
 e23-20020a50d4d7000000b005381d3b172fmr49263edj.3.1696310517644; Mon, 02 Oct
 2023 22:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231002151023.4054-1-ansuelsmth@gmail.com> <20231002151023.4054-2-ansuelsmth@gmail.com>
In-Reply-To: <20231002151023.4054-2-ansuelsmth@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 3 Oct 2023 07:21:46 +0200
Message-ID: <CANn89i+eSWYuE=wE1TPJFtAS1OCfFYytC_nAjDWkizxmR9e6JQ@mail.gmail.com>
Subject: Re: [net-next PATCH 2/4] netdev: make napi_schedule return bool on
 NAPI successful schedule
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
        Nick Child <nnac123@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
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
        Wei Fang <wei.fang@nxp.com>, Alex Elder <elder@linaro.org>,
        Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
        Bailey Forrest <bcf@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Junfeng Guo <junfeng.guo@intel.com>,
        Ziwei Xiao <ziweixiao@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rushil Gupta <rushilg@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yuri Karpov <YKarpov@ispras.ru>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee@kernel.org>, Dawei Li <set_pte_at@outlook.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Oct 2, 2023 at 5:10=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> Change napi_schedule to return a bool on NAPI successful schedule. This
> might be useful for some driver to do additional step after a NAPI ahs

This might be useful for some drivers to do additional steps after a
NAPI has been scheduled.

> been scheduled.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Yeah, I guess you forgot to mention I suggested this patch ...

Reviewed-by: Eric Dumazet <edumazet@google.com>
