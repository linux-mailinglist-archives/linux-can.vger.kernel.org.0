Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9045D770567
	for <lists+linux-can@lfdr.de>; Fri,  4 Aug 2023 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjHDP72 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Aug 2023 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHDP71 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Aug 2023 11:59:27 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C833FB2
        for <linux-can@vger.kernel.org>; Fri,  4 Aug 2023 08:59:26 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a47e8e38dso295191cf.1
        for <linux-can@vger.kernel.org>; Fri, 04 Aug 2023 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691164766; x=1691769566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqUvIC5ju3jJjQ4npEN8Nw9UixOna85OYXV2mub3SJU=;
        b=o1cnHoiuDdgnvDIwfom5WLrxCfTP9QL8EqV24c15IXkf7giRkLwXQeGaRLRril/U16
         8w3+g20Z1fPlcmhUP2+HZPchYhUYM8EaMxPd+3VliE2nrYmRllmwgT3i7CO4qiPQ6d7O
         ZuWSjFFPe1MvLBaD5WRKsTBx8DcnH+gnQXvsIfQsRjm5DUr4glEQj2hPnlHZYKP0kVgn
         CTd8KGQ2b0xblL826ZuNNy1Y46s1Yg7fLTawutNHYGHFCa+Q7CWG+X8jnTiy0e4EIXNZ
         z0pzp5EL7Cminm9dgEemp2QBdu/LsX2FfXts7OA79O3cW96a3ahhIMeUDo2KV7cJ2zAh
         7WoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164766; x=1691769566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqUvIC5ju3jJjQ4npEN8Nw9UixOna85OYXV2mub3SJU=;
        b=J2kaNtiMKTHMsjzNBlMNfPPnPFFTOYKQ236k6Z8FIwG+w70uconLzHuI7LSnukCMVr
         j9Z3NCQzKXM0Ht49JfQ+RmKJ3gym2vvGueV42Buq3gzxSCY0qzEe5NMcBf5TBuJ62luh
         Z4Kco7p/V0TxghARnPXv/Eudmmg2L1J1Z7tj0eZGJqxZck6Saj5DSj8BfnLrQ9Y4f+NQ
         +YX5p4EMEJXmlCWWmgkz6cG/YntRcveos8FWqQlGxrQU4XDnCBCdUfg26qo0jYtL4rjL
         NrNVkaKZhaug/0zWgsw0eaxV1VVfdOeSSnz/HNWtQQnE6m47s220wcWYcQhTvLNeS6r3
         8IZA==
X-Gm-Message-State: AOJu0YxNrprx+uv+2S1FabwzRni3EQra7OJT0IZmyMDV6pILihmLDOzQ
        QXYBNy470XzMNE5m3QSqaevpalArKXs6txj9QKFK3TwlDdNup6ycKuU=
X-Google-Smtp-Source: AGHT+IGoKbpPR8hPonXRhgA1WOa8qcIRjCsynB4/0ooel+zveTSU7siOZEm3GMWGJgMR7a9vsodIRU2cI2vKyN4N5sA=
X-Received: by 2002:a05:622a:1aa7:b0:3f4:f0fd:fe7e with SMTP id
 s39-20020a05622a1aa700b003f4f0fdfe7emr208967qtc.3.1691164765822; Fri, 04 Aug
 2023 08:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230804112811.42259-1-socketcan@hartkopp.net>
 <CANn89iJKNSOp+1SQuD_T3M2TQo-4HOsYVV6MwoPVwQjdrb7JKQ@mail.gmail.com> <e1826185-af12-c32a-6664-5080af03824d@hartkopp.net>
In-Reply-To: <e1826185-af12-c32a-6664-5080af03824d@hartkopp.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 4 Aug 2023 17:59:14 +0200
Message-ID: <CANn89iLWfZyDb2CMUjaKn7GW9nQE4M85=sWN_6Lk=pqNH+g=+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] can: raw: add missing refcount for memory leak fix
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org,
        Ziyang Xuan <william.xuanziyang@huawei.com>
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

On Fri, Aug 4, 2023 at 5:47=E2=80=AFPM Oliver Hartkopp <socketcan@hartkopp.=
net> wrote:
>
>
>
> On 04.08.23 14:12, Eric Dumazet wrote:
> > On Fri, Aug 4, 2023 at 1:28=E2=80=AFPM Oliver Hartkopp <socketcan@hartk=
opp.net> wrote:
> >>
> >> Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
> >> a new reference to the CAN netdevice that has assigned CAN filters.
> >> But this new ro->dev reference did not maintain its own refcount which
> >> lead to another KASAN use-after-free splat found by Eric Dumazet.
> >>
> >> This patch ensures a proper refcount for the CAN nedevice.
> >
> > Hi Olivier
> >
> > I would feel a bit safer with new longterm device references if you
> > could add an ro->dev_tracker and use netdev_put() netdev_hold() and
> > friends ;)
> >
> > Thanks !
> >
>
> Hi Eric,
>
> the netdev_hold() mechanic has been introduced in Linux 6.0.
>
> Would it make sense to take this patch as fix for all the current stable
> kernels and move to the dev-tracker as improvement via net-next as usual?

Good question.

My take on this, but others might disagree :

I think it is better to cook a patch for current upstream kernels.

Then we will adapt it when backporting to old ones, it should be
relatively easy.
