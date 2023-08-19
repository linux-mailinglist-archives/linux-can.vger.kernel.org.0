Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E8178172A
	for <lists+linux-can@lfdr.de>; Sat, 19 Aug 2023 05:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbjHSDXs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Aug 2023 23:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244849AbjHSDXl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Aug 2023 23:23:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC522701
        for <linux-can@vger.kernel.org>; Fri, 18 Aug 2023 20:23:40 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34b01711a15so57705ab.0
        for <linux-can@vger.kernel.org>; Fri, 18 Aug 2023 20:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692415419; x=1693020219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE56BA+fjk8/z3qvl6qq/GPKLP13SHW87kDx4EuRSw0=;
        b=3I1rU9H9rqRgHY2QkBBZcK4ymBmaj+bqn5e86MzshNOSE1kSP21V44AlgsQZWFjaXA
         im90AOesezLS3/sNC2niPKyHBxBzIss7jAXPl1KbFWMj6SrOydboDUuob0+PJlNPUf/O
         1NPQpdWnIZSd1+2Oh1iNnnxyQOXKE0KjUAGu3RIT5M9iuXn5a4qguwOUtxwXMyKV9OLO
         wMq4MHEDItBf+BcHkpx6DYpMu3W68yFM4iAy/OB9ddQKbfpehPB2dtXLWEG1CrMTuhXz
         EMlFulCd6HbMIZBaAsiFNpn2BDe6WWba+MiwI160LXuFuUfymARJWUavRDFk9y+6IInY
         Crzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692415419; x=1693020219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE56BA+fjk8/z3qvl6qq/GPKLP13SHW87kDx4EuRSw0=;
        b=f3hhUWQ00jN7z5otiTkcp8u0WAxQn+6zPyhX02JLX8BkpXA8cz51I4j4zf2B+VMPd8
         fp4bGVwcXk0T3cbJhB8ex370gW2YzZgt378mo/PFpOr6F+iijSKSf6wJAcY2ZcpuUjpv
         QNlzmRrZa44YoRYhrMUpFUtUCSmHBhDZ3WtSNGlwMTp5SNQyPiG2rJXK9VzfWbt9h3As
         5WqH/fl+qMviQsu3c/QXGzMOZif7V12vJb3XKzVXDO4/QYTbok0Nl8MUByhTXzKcu1kd
         T86yhN5dpsZjC7Ok2i/p/ZyVbhljEl9ZpjsCEOD+LHy3Hhvl4yQIeG5+NOHX6lDbccXb
         ndLg==
X-Gm-Message-State: AOJu0YwraTf/FoXhlGsb7BnyFXRoCWiK3Jt0Og2p+SZJOzaZbstq2AaZ
        RSsE9x+C/U/waVs0aSHuGT512ScYbFcorudtTNnF+Lc7Awr5OqBGSTo=
X-Google-Smtp-Source: AGHT+IFR47N9u0TH7mIkOMfDcOzMPWv0Z04MxXtBy1b6R3HfQI1/EJLUTf5amDGAYHVzNsjmpVkg9j/lxgBUg0qnvaQ=
X-Received: by 2002:a92:c542:0:b0:346:676f:3517 with SMTP id
 a2-20020a92c542000000b00346676f3517mr367257ilj.11.1692415419206; Fri, 18 Aug
 2023 20:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230819012602.239550-1-kuba@kernel.org>
In-Reply-To: <20230819012602.239550-1-kuba@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 19 Aug 2023 05:23:28 +0200
Message-ID: <CANn89i+DzusGJEZQYXe+z_zDzj7deYvWrxG7G=9L3Q+r1P0h9g@mail.gmail.com>
Subject: Re: [PATCH net] net: validate veth and vxcan peer ifindexes
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
        syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com,
        wg@grandegger.com, mkl@pengutronix.de, idosch@nvidia.com,
        lucien.xin@gmail.com, xemul@parallels.com, socketcan@hartkopp.net,
        linux-can@vger.kernel.org
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

On Sat, Aug 19, 2023 at 3:26=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> veth and vxcan need to make sure the ifindexes of the peer
> are not negative, core does not validate this.
>
> Using iproute2 with user-space-level checking removed:
>
> Before:
>
>   # ./ip link add index 10 type veth peer index -1
>   # ip link show
>   1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mod=
e DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>   2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel st=
ate UP mode DEFAULT group default qlen 1000
>     link/ether 52:54:00:74:b2:03 brd ff:ff:ff:ff:ff:ff
>   10: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state=
 DOWN mode DEFAULT group default qlen 1000
>     link/ether 8a:90:ff:57:6d:5d brd ff:ff:ff:ff:ff:ff
>   -1: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state=
 DOWN mode DEFAULT group default qlen 1000
>     link/ether ae:ed:18:e6:fa:7f brd ff:ff:ff:ff:ff:ff
>
> Now:
>
>   $ ./ip link add index 10 type veth peer index -1
>   Error: ifindex can't be negative.
>
> This problem surfaced in net-next because an explicit WARN()
> was added, the root cause is older.
>
> Fixes: e6f8f1a739b6 ("veth: Allow to create peer link with given ifindex"=
)
> Fixes: a8f820a380a2 ("can: add Virtual CAN Tunnel driver (vxcan)")
> Reported-by: syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

SGTM, I was not sure how to fix this myself ;)

Reviewed-by: Eric Dumazet <edumazet@google.com>
