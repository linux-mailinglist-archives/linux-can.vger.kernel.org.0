Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A807B6C0
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2019 02:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbfGaAUu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Jul 2019 20:20:50 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:33000 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387433AbfGaAUs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Jul 2019 20:20:48 -0400
Received: by mail-lf1-f50.google.com with SMTP id x3so46152312lfc.0
        for <linux-can@vger.kernel.org>; Tue, 30 Jul 2019 17:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=capp-tech-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNrVZ1J3pYD7M0R1dPUexugk5dfX0tUlXefDvKcqyY8=;
        b=bQZm/v2E7fn0M3XZbPBNbxzfRcI1TcBtBUmCpiYmhp3He/mB2p0Ej09uqnknAmZ2wK
         hXsBADxvABsVnHZXeBiCpK+C3dewu6/tT2UjgRtcXSxUU4jvS0MFMpmZ9CkJppupdiom
         fsUzx8NAZPul+2EIjNXHjKoJqyNi0bUXOo0an/j1CdTJuC4uL/kd6J6XstH75GIV0t1c
         AKe8mxhfZ9jDZu68Vh9y28vB1NMVpPKTG6FRoSfzHonEXO+R0s5Xjt/prbrHvqfh7sNj
         cwMdytbotxdZnqI8pBBoIg3RoNVyNdZCtmf6UleNr/bbq36E72JNu4S5U1ZOvqkAhCaP
         4yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNrVZ1J3pYD7M0R1dPUexugk5dfX0tUlXefDvKcqyY8=;
        b=W5mHXxNdT5V7RxOxSuvxgxhfD1BI0dAAjNVBf08Zyx+lE/aF/Kiki/PyJe9tN99IgH
         jujEk4ANh64Ahe4Nxmx3eCGepHqw0GI/7YOvQBERYZLnafoj/GupQoCTHUSZLfeF/Eco
         IrOQfZ5wMD4DN7EInBLWok689fX4OXIxnvL98DlGtZIPbx1UZZIOzMhYK4O3eqbq/B9t
         uYOcfb/r6z4rik4TAzty02J3ljxeurdovFpc2jVKYh8wZ8hB8d2I9j9LpuOyZE6j49Wb
         aITZHRfJAU6oka3kJ1U8ZEOKelxElSGP2v7JFDSTmZoiGBWx32f9wjAyvEGSiH1BecRR
         tOjw==
X-Gm-Message-State: APjAAAXHLNlncyKPOKrOh3M6immZFRDzi/l9bb/Kg0Fy8zTA83WM9nwd
        RY8V026IdzJToK3/0+A5gdytnVEvPG9bqY40lCNmg7VlqOo=
X-Google-Smtp-Source: APXvYqw/kJs7HYJzTa4PxMIXUz1a32OF9sdWN55bxQnVZkhRpsDgqt30Z1qg0v6HyN7EklMnXiUMfJye+2cu3r/NG+w=
X-Received: by 2002:ac2:46ce:: with SMTP id p14mr40488434lfo.148.1564532445853;
 Tue, 30 Jul 2019 17:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <CANRGksjUg8r5zwCpnat_UhX0EP3PDcyazApNSxqc6R_iu0Tqtg@mail.gmail.com>
 <d48e0b11-2fa7-eafe-6ec5-fe4a84e33c14@pengutronix.de> <CANRGksi1Wk2qoeSGTG+q4KBjRDxa_qZQCxyamr5PXOeM62witA@mail.gmail.com>
 <5cf240d7-f9bc-1cff-5ce0-bd3f5f437d9c@pengutronix.de> <CANRGkshiaL9QXMt8s15FydRdL9uF-zBqKw07fVn6JvJaob0umw@mail.gmail.com>
 <f6c215d0-59c1-dcc2-7605-70198ef3f9ad@pengutronix.de> <CANRGksgZE7tSwAyuhWo9_c7LwXO3hrvhqZwfUyyH0c5xYS_WpA@mail.gmail.com>
 <4b097fd5-3b17-b2c6-b9f4-f8cb0c404073@pengutronix.de>
In-Reply-To: <4b097fd5-3b17-b2c6-b9f4-f8cb0c404073@pengutronix.de>
From:   Tom Prohaszka <tprohaszka@capp-tech.com>
Date:   Tue, 30 Jul 2019 20:20:35 -0400
Message-ID: <CANRGkshc0uMwL+WEZB6CBH720N69ggEyOaZx7H7FqYpgJcyKhg@mail.gmail.com>
Subject: Re: Microchip mcp25xxfd can controller driver- BUG: using
 __this_cpu_add() in preemptible
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@martin.sperl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sure, no problem.  I have tested, but is there anything else i need to do?

On Tue, Jul 30, 2019 at 2:02 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 7/30/19 2:59 AM, Tom Prohaszka wrote:
> > You ROCK!  Thank you for finding the issue!
>
> You're welcome.
>
> Can I add your Tested-by Tag?
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
