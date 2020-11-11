Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1E12AFAFD
	for <lists+linux-can@lfdr.de>; Wed, 11 Nov 2020 23:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgKKWFc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Nov 2020 17:05:32 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:60066 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKWFc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2020 17:05:32 -0500
Date:   Wed, 11 Nov 2020 22:05:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acoro.eu;
        s=protonmail; t=1605132327;
        bh=YwiOtjh3dkSm3ETj7PtSFmBV9QRYMwHkwGv/h8sSZ3w=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=XIzRr76U8o8ou9QD+vYiGP5OUZCyEyfhSW8RhLkkvy0yccz7kCldbJc6DKj0ipnvk
         S/sUK1ggclxlCPgVJomAexE4E/RcKZicatgl9K+uZhXmqA8lG9zRA++0oRqH6ii5pc
         tKKw91r7Ks2O/Fk8gs4wDUQyn0VB8zCYaqmewCj1ezazUIOreEhVwfJWmRjl+ch9nM
         Wq5SjTCI0eB/1Wj3oJ2iLvLpNTYA9tO/dNTyewwS3CHkedbBdq3Y9mVt9awHo214XJ
         Tm7mE0w0E6vy0pDzzMy9oQqHkqJ/2gjTjbHUS+PCjj5cxmsAzZ7De5WOC7oF0tWtNa
         L3XjOsk5j2GAg==
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
From:   Alejandro <alejandro@acoro.eu>
Cc:     wg@grandegger.com, davem@davemloft.net, kuba@kernel.org
Reply-To: Alejandro <alejandro@acoro.eu>
Subject: Re: [PATCH] can: dev: can_restart(): post buffer from the right context
Message-ID: <fec3e267-fe82-6967-89e1-70dd09924a35@acoro.eu>
In-Reply-To: <fa4fe13b-b98b-ccb4-64c8-116d682b0162@pengutronix.de>
References: <bd6d51f4-4a18-e557-46d1-00d3539d163e@acoro.eu> <4e84162b-fb31-3a73-fa9a-9438b4bd5234@acoro.eu> <e8dc38e5-5f4d-a1c9-8edb-d612b781467b@pengutronix.de> <2e152de6-a3b1-ad81-981d-423835eb184e@acoro.eu> <fa4fe13b-b98b-ccb4-64c8-116d682b0162@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks for quick response. I'll send a second version of the patch if that'=
s OK :).

BR,
Alejandro

On 11/11/20 22:48, Marc Kleine-Budde wrote:

> On 11/6/20 6:33 PM, Alejandro wrote:
>> On 6/11/20 11:25, Marc Kleine-Budde wrote:
>>
>>> On 11/5/20 10:51 PM, Alejandro wrote:
>>>> From: Alejandro Concepcion Rodriguez<alejandro@acoro.eu>
>>>>
>>>> netif_rx() is meant to be called from interrupt contexts. can_restart(=
)
>>>> may be called by can_restart_work(), which is called from a worqueue, =
so
>>>> it may run in process context. Use netif_rx_any_context() which invoke=
s
>>>> the correct code path depending on context.
>>>>
>>>> Co-developed-by: Loris Fauster<loris.fauster@ttcontrol.com>
>>>> Signed-off-by: Loris Fauster<loris.fauster@ttcontrol.com>
>>>> Signed-off-by: Alejandro Concepcion Rodriguez<alejandro@acoro.eu>
>>> I think we either call can_restart() from a netlink callback via
>>> can_restart_now() or via the can_restart_work(). So we should always us=
e
>>> netif_rx_ni(skb), right?
>> Right, I think that currently it is as you say. However, it seems that
>> can_restart_now() has public visibility (/linux/can/dev.h),
> Yes, but it doesn't export it's symbols. I've removed the function from t=
he
> header file and everything still compiles.
>
>> and even though
>> it doesn't seem to be used by other CAN drivers for now, I guess it coul=
d
>> potentially be used in future. netif_rx_any_context() should avoid issue=
s
>> if can_restart_now() is called from an ISR later.
> I don't see a valid usecase where can_restart_now() is called from an ISR=
. We
> can change this if an uscase pops up later.
>
> regards,
> Marc
>
>

