Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038AB3489CA
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 08:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhCYHDF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Mar 2021 03:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhCYHCh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 03:02:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F94EC06174A
        for <linux-can@vger.kernel.org>; Thu, 25 Mar 2021 00:02:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so1187501ejc.4
        for <linux-can@vger.kernel.org>; Thu, 25 Mar 2021 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hey6njuL8Kor2elwAwvEB5i/Y9yU86HiVwrWd3muglY=;
        b=TREzbOOLdLIBhnlAi1B/qBZemz0SF5Tm5H+bFJ3Nk6pRNJ7CAHcThQr5H3pzrj0v/o
         +aX53EAZPGYIxL2gMC5ESok5w6Fr/Q1CH9YVdOLzca8u9UkQTCYvKFuhNZOkvRuTz8wj
         FkRwjtubeF6lK7R3iUsLTHgA9OLgWcL10OvxSyO0NrStrLaJu12VpsG5y/vNoLA9mB8H
         2dePaZSMLY75OXhbcwZDpA/Dn1I9/c79TskMi6+m4nYtyAB/dKV8hUIXSAfv9m4UAUDw
         ywBCOUCFHPQLDEC/hSPKfNIDziHWjTwRu+tqfro9LahzviqDzIv1LVmO7EAucfwBtHaG
         OHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hey6njuL8Kor2elwAwvEB5i/Y9yU86HiVwrWd3muglY=;
        b=Lu6Lyx1i39LRuakDHDYMdH4JvJsBIq/sbcVe72ImoVVJQZksNG7RsfIoJvkZsknHzV
         9f2v7kO81FnTGP/oySG2z+p9dc6Ktskhj2tJOYgFOAVEi0OngnEFFRTO9vUXGb57nR84
         NiTk27cIHmg1Ll02mEIhEg2RGlG1HAj7f+W5HFnGM9QPEr5R/YqG2LHHgMOv6IAPyi2R
         YPJXun0At9pRQ0BNq0Dk7TwrzmfA+mn7qc4d89eScUfERyqk87RVJwMI65Ed5rCMHJ+R
         UtVvTKuWaxiTqD2bZWLYu6KLYE322P6ShKto9ShlyERpuF+Z374X7oyTAC0TZ6E3nLzf
         bLNw==
X-Gm-Message-State: AOAM532VZtr3ZFf9cOwGDV+rITibqPGyO41aC5+efvn1OL178UPzR9xm
        RAxbxarcv8J2Qhu4gDxIYUeRtjxhf0GmFQ07w7o=
X-Google-Smtp-Source: ABdhPJzm4RmTM4l6W+qS7o3hpkdMxAuFjwOtRBIp4a0yemHuk1vZWM+sfUnB8zLlsK79DGo5kow23pgYdRdbW7Vy8cA=
X-Received: by 2002:a17:906:b80c:: with SMTP id dv12mr7843568ejb.110.1616655756160;
 Thu, 25 Mar 2021 00:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <2a2f2f06-00ed-7418-b5b6-ea7eb729d4f5@posteo.de>
In-Reply-To: <2a2f2f06-00ed-7418-b5b6-ea7eb729d4f5@posteo.de>
From:   Christian Gagneraud <chgans@gmail.com>
Date:   Thu, 25 Mar 2021 20:02:25 +1300
Message-ID: <CABxGUTh-ADKYe9kMkyc_VPcMTB-BkCh-oFy1qCjkSZMJFbtg2w@mail.gmail.com>
Subject: Re: CAN Testing with Docker Image?
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

Some time ago, I wrote https://can4docker.readthedocs.io/en/latest/ as
an experiment.
It is unmaintained, but was working back in the days.
I'll eventually get back to it when we'll actually need it at work.

I think there is interest in it. Unfortunately, no time at the moment
to bring it back to life.

Chris
