Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A2C3D57B2
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 12:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGZKCM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhGZKCL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 06:02:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7634C061757
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 03:42:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c16so5459608plh.7
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacecubics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNzT2nsKTJdEy7tlEFHg9dewHFuiQuyG1wQ2OF6nQZA=;
        b=eukoj94D5X5XW+eQ47ZYMFoRS57cKUvF+dhG69iY4J6lps8cxjktZKhjOeTaBbyPmE
         CTh3GC5XaZHnrqQhQH6CG9nXKUMIJLEVeDSrxOzNJoOm8Uqa1ZFCNBh2mCr7rBGeNq8C
         9nOhrtUGHerELI3arWaVkMS7Zl4eBeR5dUp2c427/FLiCowO2uUlY8weNbckG+5NN1tC
         wjv5HzKYFdkFm1gj6mPDI1EQliuyC1HadrfFAOoJsanbXxNPUvt7XrPqpcL5LFasgAL3
         hbJV+CXWQHIlUqyPZJ/Gumb7e9hJ97wutvsxFNVdtT9t9dtPyivVPel9BzD8iiUwKX/t
         VO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNzT2nsKTJdEy7tlEFHg9dewHFuiQuyG1wQ2OF6nQZA=;
        b=aNS3RuPI9iPTLxW5QVqRys3Eg9nq0ch6Q1MLW5m86QVtHboSLijjhNWfJuK1oAQQmj
         XIj98Cc4DvkXOYhOaFSIOYHF4pCzB+4CU4DB8ulJAGoweTjth+3yxhW0Dtodbrqtm4gm
         S3XPU4fEjFdJo09TkqL4GQpgaDS+5O/ImNjZymoORRzwBHMUhgS6IS8jDlvHWIdL0jZ7
         TvdQxZT7DajqEClcenDjg6uUfCROLtum7/yCoFFDt3qFrFKgk+EqNL5sf+9WOKdySOGf
         DaRlnwacybIDhRiQNTn0GUNSR5hIlUO09BQE6tcL33XX1bSqe8Snz6I1WomY/8BWS5vH
         Lj3Q==
X-Gm-Message-State: AOAM532HL8IpeLbyX6fSpfLdaTcujw52uxhIdpu6k/LNu92hTQGx8SWZ
        UR2lWKQCuKqJVxDh1GzT16l2Ly/ogvTaHxwob5udAw==
X-Google-Smtp-Source: ABdhPJwAr+0Lx/PmqkBVuPpJ0A6HKcDZ8I+E9wZn6GrURl5xuvWC+HjOM6Omfars88/OWCRDi8LkgB3O8ZhHfZwfsBg=
X-Received: by 2002:a17:902:eb54:b029:12c:3612:b6e0 with SMTP id
 i20-20020a170902eb54b029012c3612b6e0mr1049155pli.33.1627296159288; Mon, 26
 Jul 2021 03:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
 <20210725111242.2d9a819f@gmail.com> <CAELBRWJQ+QN6+D0M-61Fz818fm7Q-pP4LW=-KUe+nsyFFSXXPg@mail.gmail.com>
 <20210725162720.74fu6qny6dqdc625@pengutronix.de> <CAELBRWKqs_XndF46Ucw9g0Y0n2q9qz-iO+CHyDvdJGMt37OuwQ@mail.gmail.com>
 <20210726093108.4uqfrvoiu5d2s4br@pengutronix.de>
In-Reply-To: <20210726093108.4uqfrvoiu5d2s4br@pengutronix.de>
From:   Yasushi SHOJI <yashi@spacecubics.com>
Date:   Mon, 26 Jul 2021 19:42:28 +0900
Message-ID: <CAGLTpnK2_v9rEvFgsp8ARrSncYLa1vqfgVh-WzGs0qESfCgehw@mail.gmail.com>
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Yasushi SHOJI <yasushi.shoji@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Mon, Jul 26, 2021 at 6:31 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Great! I've send an update to the MAINTAINERs file, Can you reply with
> your "Acked-by:"?

Acked-by: Yasushi SHOJI <yashi@spacecubics.com>
-- 
           yashi
