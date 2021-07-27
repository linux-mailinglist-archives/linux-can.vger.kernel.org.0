Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79D73D6BE1
	for <lists+linux-can@lfdr.de>; Tue, 27 Jul 2021 04:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhG0Bja (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 21:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhG0Bj3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 21:39:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875FEC061757
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 19:19:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso1931861pjq.2
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 19:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacecubics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJTYTqeiPr7O6j38Vm+ZF8iO5nrhTQe3Rtg5btGRmjI=;
        b=hoJcCc2kJGdJnPSBfHVErE+vu2as6cfi5jll41nuDvYwzCfCsjkichLUYGegAfjks/
         +kSxafy/6eWQJnOsAXZmgU1o6uDq0gho8AGb7kTl0B4zAIwLrG8mZYj0Gi65Fx61X+sN
         FbQgtpi6kpYhUHev4HuVCG3hDP17D/zur92yUAUkM+wub7ZefZ8caUsxuy7TjUDKpKGs
         3euqN8IEYS7jOxVZyzPoRewRHfEqSVpjOVDfjQhsO41twyg/LYc3nvIZ0fKGamY1NdyS
         DEwsjveDddo6NT93hGJJvUptvqvUerY55iw+MjWp3T9SIBgGuv6pmATfbL5LHBjyXyPa
         u1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJTYTqeiPr7O6j38Vm+ZF8iO5nrhTQe3Rtg5btGRmjI=;
        b=j8NWKuOpwkjbpQtqZMBuR22u0KyL1c4cZs9k1q0jC5hBhlhich90YgH1W0syRSy048
         YGHNUF2PlCC4X1lAs2BIM8jMQFt9I7s7LGlube53nIubuBoC8ohKoDQ/Su5zj11bFpll
         yEDDbr2GaOZg8ZzJRS+KDD65kWWxFfmVbjjpm6LEBu/+ybq823jv9MA0iJ0YZcroUage
         zC7zLqNnfwSVrSEDJHZ5ET22piJT02/Vstvlzuqne2MviopFR0UQa9ZmvHjlUWphaYzv
         dRTztHEO9pWIVtVGUCoP5yDEsUaMAit0CfHmTahNDbvcCHBhaIb+V8I8L3oCsqeDuJZD
         /7pQ==
X-Gm-Message-State: AOAM531gm320lROWLYPbSjeiy6qsu5BfoDU2FJIIhe6yw0Pr4KruUj69
        1VUrPAOSkNMeTpO+3KY3MJ5q/g3MAzKXw3996ZdaUg==
X-Google-Smtp-Source: ABdhPJx4rRdlGScUYyX5Ch7Z/w5SY1Lgm4amdw4lY251WBtEYb/o3cgTs14ONDkqE2aZnmnEq0y0L6SZPrAVLRe/T9A=
X-Received: by 2002:a65:6494:: with SMTP id e20mr21458081pgv.101.1627352397085;
 Mon, 26 Jul 2021 19:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
 <20210725111242.2d9a819f@gmail.com> <CAELBRWJQ+QN6+D0M-61Fz818fm7Q-pP4LW=-KUe+nsyFFSXXPg@mail.gmail.com>
 <20210725162720.74fu6qny6dqdc625@pengutronix.de> <CAELBRWKqs_XndF46Ucw9g0Y0n2q9qz-iO+CHyDvdJGMt37OuwQ@mail.gmail.com>
 <20210726093108.4uqfrvoiu5d2s4br@pengutronix.de> <CAGLTpnK2_v9rEvFgsp8ARrSncYLa1vqfgVh-WzGs0qESfCgehw@mail.gmail.com>
 <20210726111738.pgdhynfnw2xaigp5@pengutronix.de>
In-Reply-To: <20210726111738.pgdhynfnw2xaigp5@pengutronix.de>
From:   Yasushi SHOJI <yashi@spacecubics.com>
Date:   Tue, 27 Jul 2021 11:19:46 +0900
Message-ID: <CAGLTpn+C14JM+zNDcEiTNL1uSBSUkkyRV5Ur-SkeM35RtLenYQ@mail.gmail.com>
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Yasushi SHOJI <yasushi.shoji@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jul 26, 2021 at 8:17 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Sorry for not being clear - I mean reply to the patch I've send.
>
> However, I've updated your email address, add your Acked-by and sent a
> v2.

Thanks!
-- 
             yashi
