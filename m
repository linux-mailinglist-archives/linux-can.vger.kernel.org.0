Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2531B901F
	for <lists+linux-can@lfdr.de>; Sun, 26 Apr 2020 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDZMqG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Apr 2020 08:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725974AbgDZMqG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Apr 2020 08:46:06 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F628C061A0F
        for <linux-can@vger.kernel.org>; Sun, 26 Apr 2020 05:46:06 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k6so15875324iob.3
        for <linux-can@vger.kernel.org>; Sun, 26 Apr 2020 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7i75YOWi+fHTXDtUwGBE+bvX7j2LJy2JitS1OYg3XQU=;
        b=kMN+g4o44HJ63e56ZTohpIjmUm75hHyBR0bG+rt1HylnmjdlapgWQQQMDKwValgMsN
         YAuxobj5cbLG6L2d5XGucMKa1wnMMYZdGNtpQ9y7fLAxhZARr8D3aZTmRf4ob4t9jT8K
         GhzjlmHT4Phaecxp0urFyaosF0z7b9dh56vLCehfg9JT8UEn1oHGGCvpHHhSOZgCajnd
         stDTv/M4U3aF31MFoQItP1OsJtXb64euz3HBSvCnTW6lQTUkbkbJtPxc8NhD9tCVLGkV
         B1vlPdaZxzNBACT4LKFqfiaEAkXzjeFPysFwqdNfTxNYnVFfX1nJjdTMHNRAKZc83QO0
         hT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7i75YOWi+fHTXDtUwGBE+bvX7j2LJy2JitS1OYg3XQU=;
        b=m6VUFNeFDAqzp7ipQ2p72F2EprPHZJfaRRHqF8snjM8pb/qMEnCFqEfqUmFh3JEt4O
         S2ApitsMeFva2KQjEh9K2vNOEGNY+HsoeupOSVuCf00A595xEeSTQ0i2LtGWn7apkk2/
         iLErHDC+EjIHYGxwSVPDYvqEKsqMKrzQRHz/U2BRWY/E9CElRdJ2TA4PyLfgpF/kUgh3
         yZVobcRuTbQzjpbdS0nvu5KCrmyHjTj6tUXNoEQdLquArxq0EYUmaO2tEWG5zPSurNva
         m7B9evVc+toIOgRnY9pbZ35gkMGng/Lo/Hrrf1HvGjok9ynGb10+upUDZQTxjycLKN4y
         ORhQ==
X-Gm-Message-State: AGi0Puap9QP2/NBwv6Izfva0VxoMnimJkIZH6p/2+5bKQGyrTJvMYJ2c
        kfuX5M96BwOdKEdldd6Qn0hCDU2WnG8jYrcR4q0=
X-Google-Smtp-Source: APiQypKojqU9ntGXU+MWtGQhuO67hnrWdwMN3rDTTsq18CFEow6esxmeLjJ+pLMMCgKdQMhKBe0/GfHwiWVaGMM3wsk=
X-Received: by 2002:a02:40c2:: with SMTP id n185mr10697577jaa.43.1587905165370;
 Sun, 26 Apr 2020 05:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAP22eLGTc6K1auF5JOofTKy83uTOq0hK_qb8fgJ=J78njwWjVA@mail.gmail.com>
In-Reply-To: <CAP22eLGTc6K1auF5JOofTKy83uTOq0hK_qb8fgJ=J78njwWjVA@mail.gmail.com>
From:   Christian Gagneraud <chgans@gmail.com>
Date:   Mon, 27 Apr 2020 00:45:54 +1200
Message-ID: <CABxGUTjxAgaMtbp0E1UWiH2HCELNtQ8F_VkT7Ja29Ma0MGK_dg@mail.gmail.com>
Subject: Re: Are there any netfilter modules for use with Socket CAN
To:     "Lev R. Oshvang ." <levonshe@gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, 27 Apr 2020 at 00:08, Lev R. Oshvang . <levonshe@gmail.com> wrote:
>
> Hi list,
> From my google search I did not find any netfilter /iptable rule which
> allows to filter on CAN fields,  message ID and other.
> Please point me in the right direction.

You can do basic filtering with the CAN Gateway
https://cateee.net/lkddb/web-lkddb/CAN_GW.html
https://manpages.debian.org/testing/can-utils/cangw.1.en.html

Hope this helps.
Chris
