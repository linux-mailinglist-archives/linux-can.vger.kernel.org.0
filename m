Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10AE70214D
	for <lists+linux-can@lfdr.de>; Mon, 15 May 2023 03:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjEOB5w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 14 May 2023 21:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjEOB5v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 14 May 2023 21:57:51 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086941734;
        Sun, 14 May 2023 18:57:50 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-643ac91c51fso7743219b3a.1;
        Sun, 14 May 2023 18:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684115869; x=1686707869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oToW+Q4w2tcSTz/9eetaZ91mGtQUL7Hi7EcIr13WLLY=;
        b=IeAqc4bkRD+CGHO0/OkA63XOZdxiNLgVzDEoPQ04abKwDM4irCbhiP1/vpL4RbznEs
         6AqbTg5YcE2szlWG8lg/m1JjAJ4JZSszXh3SlFsMMuCqP0xGow/gpqKPDACas414aYGB
         7VLlyRkOnoJfIU4BdAu2DMSwvGxzDjBPj2CfXrcXMmQbdzVuR4qw3C67O71vL3MHn3YQ
         qOwjnkOcqpIcyvxprfQun8QqWp2Y7vatHgyJ8qBcHp0U0JmfrRmG7+IAy5qmBsZP+2ig
         /CveHKzRmM1AkcS3ZxNts7DcYxok/NDYobMMNTri8eWDQO7wBYn8Y4ScpZwN+PidI7Va
         kLHw==
X-Gm-Message-State: AC+VfDwMYaOXD+Lza1y0B2MtJnBHqKQ0raxrbEtQqPwOl+rfYisnwTJs
        BFVZdjEHp6Win0QDwQ1b+480qG5mLF3+7rEVKDQ=
X-Google-Smtp-Source: ACHHUZ7QQbsfBQEX/50EZXE1XqUPz5dZyZveSsEAVlIbbPNJhqY3pR72jRdpUIIoZINWjFYTy9H4sZ4mv66tFORo0sM=
X-Received: by 2002:a05:6a20:748c:b0:104:ffd0:2338 with SMTP id
 p12-20020a056a20748c00b00104ffd02338mr8596245pzd.26.1684115869303; Sun, 14
 May 2023 18:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230511151444.162882-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <CAMZ6RqJbjoApwZbiivbvJRYQyBWfWXG4azmwuXGaicrMq0Lozg@mail.gmail.com> <3950ac4f-3292-e6ca-7484-77f3a5639305@opensynergy.com>
In-Reply-To: <3950ac4f-3292-e6ca-7484-77f3a5639305@opensynergy.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 15 May 2023 10:57:38 +0900
Message-ID: <CAMZ6RqLu9hjTApnU3C-OWiZp_1yjSTWe9jBhgajmfEezM9_s+w@mail.gmail.com>
Subject: Re: [RFC PATCH v3] can: virtio: Initial virtio CAN driver.
To:     Harald Mommer <harald.mommer@opensynergy.com>
Cc:     Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat. 13 May 2023 at 23:18, Harald Mommer
<harald.mommer@opensynergy.com> wrote:
> Hello Vincent,
>
> sometimes it's close to weekend and already late. I've to correct myself.

Yeah... I understand that. There is no hurry to answer quickly (and
this is why you see my answer just today). Hope you had a restful
weekend.

> On 12.05.23 11:53, Vincent MAILHOL wrote:
> >
> >> +static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
> >> +                                        struct net_device *dev)
> >> +{
> >> +       struct virtio_can_priv *priv = netdev_priv(dev);
> >> +       struct canfd_frame *cf = (struct canfd_frame *)skb->data;
> >> +       struct virtio_can_tx *can_tx_msg;
> >> +       struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_TX];
> >> +       struct scatterlist sg_out[1];
> >> +       struct scatterlist sg_in[1];
> >> +       struct scatterlist *sgs[2];
> This 2 here.
> >
> >> +       /* Normal queue stop when no transmission slots are left */
> >> +       if (atomic_read(&priv->tx_inflight) >= priv->can.echo_skb_max ||
> >> +           vq->num_free == 0 || (vq->num_free < 2 &&
> > Replace the Magic number 2 with a #define.
>
> Is this 2 here.
>
> Obviously with my previous answer I switched into panic mode thinking
> already about explaining indirect descriptors and all kind of virtio
> details and the expression in depth not realizing any more that
> something different was requested.
>
> Appropriate answer:
>
> /* CAN TX needs 2 descriptors: 1 device readable and 1 device writable */
> #define CAN_TX_DESC (1 + 1)
>
> Or something with ARRAY_SIZE(sgs) to get the number of elements in sgs
> keeping the first 2 above.

ARRAY_SIZE(sgs) looks good! It is better than a #define.

> And then I'll have to think again whether I really want to keep
> sgs_in[1] and sgs_out[1] as arrays. Not now, now is weekend.
>
> >> +           !virtio_has_feature(vq->vdev, VIRTIO_RING_F_INDIRECT_DESC))) {
> >> +               netif_stop_queue(dev);
> >> +               netdev_dbg(dev, "TX: Normal stop queue\n");
> >> +       }
> >> +
> >> +       spin_unlock_irqrestore(&priv->tx_lock, flags);
> >> +
> >> +kick:
> >> +       if (netif_queue_stopped(dev) || !netdev_xmit_more()) {
> >> +               if (!virtqueue_kick(vq))
> >> +                       netdev_err(dev, "%s(): Kick failed\n", __func__);
> >> +       }
> >> +
> >> +       return xmit_ret;
> >> +}
> >>
