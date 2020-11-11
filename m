Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E672AFB36
	for <lists+linux-can@lfdr.de>; Wed, 11 Nov 2020 23:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKKWQz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Nov 2020 17:16:55 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:45739 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKWQz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2020 17:16:55 -0500
X-Greylist: delayed 4900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2020 17:16:54 EST
Date:   Wed, 11 Nov 2020 22:16:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acoro.eu;
        s=protonmail; t=1605133011;
        bh=SxSmwJ3WKvu34Hko62O7m61JU2L67LQAajD4qJxTyP0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=bkNrRR2/H7LGgQBeptAB0Bg102MJNzDIcmZu9vebiv4S+UT3ykBUEwPD3GXjn9thG
         jTnMfqkaWgUrdHGSELyFdNS1kTAJknUlDQtlH/pVkOZhR0/cMLjS/C18r6IVyXGXgG
         eauJ0T4ajiS2GedAbDOyedRrYaBuPJRx4dMrHnJHXo8JPCyZ79dVQvXWOssPZuml8O
         R5RU1G10QqbW8UEaSeEMsqMbvMJ5b8GYKmOkwhd4Xz/4zTR9KsV40/2bj7DpsiFjGL
         sq1RZUtDXUhpQPkipczAvOeqB6oqDGorI76WogkwR1MulT4gBWXJok77H6vChEJItz
         GzEmy5Ef8vE2g==
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
From:   Alejandro <alejandro@acoro.eu>
Cc:     wg@grandegger.com, davem@davemloft.net, kuba@kernel.org
Reply-To: Alejandro <alejandro@acoro.eu>
Subject: Re: [PATCH] can: dev: can_restart(): post buffer from the right context
Message-ID: <bee7749e-63a9-5a58-1bcc-a2cf1fb51e55@acoro.eu>
In-Reply-To: <8e58ee2e-34d2-3d4c-e630-5f7460192841@pengutronix.de>
References: <bd6d51f4-4a18-e557-46d1-00d3539d163e@acoro.eu> <4e84162b-fb31-3a73-fa9a-9438b4bd5234@acoro.eu> <e8dc38e5-5f4d-a1c9-8edb-d612b781467b@pengutronix.de> <2e152de6-a3b1-ad81-981d-423835eb184e@acoro.eu> <941f4435-678f-aaa4-88f6-0240a36a893c@acoro.eu> <8e58ee2e-34d2-3d4c-e630-5f7460192841@pengutronix.de>
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

Ok, thanks!

On 11/11/20 23:04, Marc Kleine-Budde wrote:

> On 11/11/20 9:55 PM, Alejandro wrote:
>> My understanding is that can_restart_now() may be called in interrupt co=
ntext
>> by some CAN driver, so netif_rx_any_context() would be safer, but I coul=
d be
>> wrong and maybe can_restart_now() is really thought to be called in proc=
ess
>> context always (so better to use netif_rx_ni()). What do you think? shou=
ld I
>> update the patch?
> I've updated the patch and applied it to linux-can/testing.
>
> Tnx,
> Marc
>
>

