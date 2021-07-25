Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924EC3D4EC3
	for <lists+linux-can@lfdr.de>; Sun, 25 Jul 2021 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhGYPzh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Jul 2021 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGYPzh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Jul 2021 11:55:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE93C061757
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 09:36:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id nd39so12455095ejc.5
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJwi4BtpDU9DQVgjNcD6W/2IbnosknmGX0re0QYTQiQ=;
        b=IyyOmgVrjT0kmb+RlYz2FTZenPPgdIId5ZGUcSJTTjeQWHxELyPxuXzOPXQPped3U6
         F9YcUIHDeiuULV/qbncSw2Sjy92VicTH00lhEGDQ+KTc37stZtOqF7hW0dm4h66jObto
         yOl0n+sof1sLPofrJn4tysOq+D878QSzDfsWes/J76QhfR9X0s2vQrOTs6Zpz+vtlwva
         kY5hsyaRmdXM1gSqBrzdBmih9DPR/0g8Iq9wN4PcsFhUJN56/hFe2U3ccKUdG4Fw3JqI
         ykTbHVs/WaVFP+ZU6uFKA3G5QYy/chMCyUsu9wzIEnBdmZzaAEiu8BLKNn4H3poCEliI
         xpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJwi4BtpDU9DQVgjNcD6W/2IbnosknmGX0re0QYTQiQ=;
        b=g4m/UVeVeqfF6h+7r/UQO735JSOHJFxYQ6eQ7+00CBTJrZ5kcdgtLziVvLLjFJaUes
         5FR8RrLBq+qhCHhlLSbi5b6XwOaCa+nK1YfQltlEuQ+kZ8qk/n6C6FAdZZip3K9/t7Mg
         0X+hoSlA8f1/rPRzGwNZOeXKVILguyIv7XT8PIsr/2DpGPSnMyct6NMT8pDRwEUSLxmA
         v2sezcbITwrnQmeWgpGfyQgzK+yCsHbLl07an9Bamc4u32EAzNnqjoJUJLg9uEnlYHdp
         6Ly0JuId1IpOzg4y9p0kO138n3O1KnTfB87/DjYgKnx6vz+/2dguf96sowM+HfjRCXlF
         m7jQ==
X-Gm-Message-State: AOAM532sWCiojOTWT5TJ534r2FhmIM3an8rtiFeNc4MzdF5vIHC1YUrW
        hRoLfFMZ4LBJii/Jro04jklY8FykEuc6EEFjBMTb/s0v
X-Google-Smtp-Source: ABdhPJxU1uyy1PaRoD0hQArU+KIQRPo9DiMWFyuTijUIRlv90apJdU6mXaBSYmXvZXT3Cs8ZNnTqVOnfZNi7lIRXlD0=
X-Received: by 2002:a05:6402:2206:: with SMTP id cq6mr17038606edb.209.1627230964751;
 Sun, 25 Jul 2021 09:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
 <20210725111242.2d9a819f@gmail.com> <CAELBRWJQ+QN6+D0M-61Fz818fm7Q-pP4LW=-KUe+nsyFFSXXPg@mail.gmail.com>
 <20210725162720.74fu6qny6dqdc625@pengutronix.de>
In-Reply-To: <20210725162720.74fu6qny6dqdc625@pengutronix.de>
From:   Yasushi SHOJI <yasushi.shoji@gmail.com>
Date:   Mon, 26 Jul 2021 01:35:53 +0900
Message-ID: <CAELBRWKqs_XndF46Ucw9g0Y0n2q9qz-iO+CHyDvdJGMt37OuwQ@mail.gmail.com>
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, linux-can@vger.kernel.org,
        Yasushi SHOJI <yashi@spacecubics.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On Mon, Jul 26, 2021 at 1:27 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Yes absolutely - but I don't have access to that hardware. Since you're
> interested in that hardware, what about adding you as a reviewer to the
> kernel. Then for every change on this driver, you'll be added on Cc and
> can test it. What do you think?

Sure, I'm happy to help.
-- 
               yashi
