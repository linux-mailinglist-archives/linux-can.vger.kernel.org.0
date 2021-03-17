Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3CD33F140
	for <lists+linux-can@lfdr.de>; Wed, 17 Mar 2021 14:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhCQNfv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 Mar 2021 09:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230507AbhCQNfo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Mar 2021 09:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615988144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RoIhEIPsIUsyZmpjJB4C/mSA9MX+NHGWNRebeNCuIA=;
        b=jMioJ4A4ofPVSrIhS32wm0Zq/05eQKKFwD3wYIDPqHtAK9AjoPswJGVLV76h27lG7VLNEU
        mxA84l9RGADcDDDoLtrP6NiFnxCXJRbFX9Czp4KmqAdjZVUs79H0CyuKnJdUqOn7I1fr0o
        ak1xee27nMDGLhFOHHQGsijufdwfVQ0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-AKVmf-yROQ2eDB1vyjeldQ-1; Wed, 17 Mar 2021 09:35:42 -0400
X-MC-Unique: AKVmf-yROQ2eDB1vyjeldQ-1
Received: by mail-ed1-f72.google.com with SMTP id bi17so19300669edb.6
        for <linux-can@vger.kernel.org>; Wed, 17 Mar 2021 06:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/RoIhEIPsIUsyZmpjJB4C/mSA9MX+NHGWNRebeNCuIA=;
        b=VKR+fdMpok8bEy0AGekiIAz+8iqMb8eRTcFPSLlNZZ0Jm8EWNcLwxu00Q5E46qzCOt
         3IEQN+PiArPH2lkhyMEA4L8AnTt+75HBcIDTe9lyQ49suEhHOYQJe3bJ4dzh9LRlsOPt
         DA607qoeXxiB/4TgFPolKEdqsRqdynDvrvTlEHrzgJN80lFVQp/bmbxoh3or6KRC3nX8
         0FrobJ9mKHgIlvg8aBHdDoZ8ywsLwFo01+Pry7kb+FH5mujU5Q9eZDCRqjguhqd0gQTE
         Ml+gXEpVbER46Q9K/hWqTYNwQUmUE7GvCdSDobxGsqWGxyYVQAZ0eIzHAMbfYhJiUFEX
         pfEA==
X-Gm-Message-State: AOAM532F0FNdIhBY+SZKC4jW+kmF2Smx1GAW1gV3VNR/ZocW+1MW1SSB
        RipojLCtq45d88KKcI6qsQsxeyP9AB0LTSlXmENnFt+MlCMkEQQTiirpClpwjKRRmlJMmeJO3cf
        z7Bp1hltEDBLoXLJHHocV
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr43393577edc.210.1615988141547;
        Wed, 17 Mar 2021 06:35:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhSou/Ggl3lyJiKJw4mWS8ik+JHdDXlS/PItqOtN6SRReDZhjCZdbefeVu8pAOm+I/A9PxHw==
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr43393545edc.210.1615988141387;
        Wed, 17 Mar 2021 06:35:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f9sm12720014eds.41.2021.03.17.06.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:35:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 35DAE181F55; Wed, 17 Mar 2021 14:35:40 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        David Miller <davem@davemloft.net>,
        Vladimir Oltean <olteanv@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Eric Dumazet <edumazet@google.com>,
        Wei Wang <weiwan@google.com>,
        "Cong Wang ." <cong.wang@bytedance.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linuxarm@openeuler.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [RFC v2] net: sched: implement TCQ_F_CAN_BYPASS for lockless qdisc
In-Reply-To: <CAM_iQpXvVZxBRHF6PBDOYSOSCj08nPyfcY0adKuuTg=cqffV+w@mail.gmail.com>
References: <1615603667-22568-1-git-send-email-linyunsheng@huawei.com>
 <1615777818-13969-1-git-send-email-linyunsheng@huawei.com>
 <20210315115332.1647e92b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAM_iQpXvVZxBRHF6PBDOYSOSCj08nPyfcY0adKuuTg=cqffV+w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 17 Mar 2021 14:35:40 +0100
Message-ID: <87eegddhsj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Cong Wang <xiyou.wangcong@gmail.com> writes:

> On Mon, Mar 15, 2021 at 2:07 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> I thought pfifo was supposed to be "lockless" and this change
>> re-introduces a lock between producer and consumer, no?
>
> It has never been truly lockless, it uses two spinlocks in the ring buffer
> implementation, and it introduced a q->seqlock recently, with this patch
> now we have priv->lock, 4 locks in total. So our "lockless" qdisc ends
> up having more locks than others. ;) I don't think we are going to a
> right direction...

Just a thought, have you guys considered adopting the lockless MSPC ring
buffer recently introduced into Wireguard in commit:

8b5553ace83c ("wireguard: queueing: get rid of per-peer ring buffers")

Jason indicated he was willing to work on generalising it into a
reusable library if there was a use case for it. I haven't quite though
through the details of whether this would be such a use case, but
figured I'd at least mention it :)

-Toke

