Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1910F1239
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 10:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfKFJdA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 6 Nov 2019 04:33:00 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:40003 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKFJdA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Nov 2019 04:33:00 -0500
Received: by mail-io1-f49.google.com with SMTP id p6so26228315iod.7
        for <linux-can@vger.kernel.org>; Wed, 06 Nov 2019 01:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q+P8Jh7kTsA5bya4Kwslqfb/4BJWoIKG0VmeGG0Dx5s=;
        b=dsu3PC7cvord8iuNGArNx0N+nUuZnv3xceS5XjWeDP2imBfegECupKBjRkHxKRNYtl
         nUqYI0YawJ9eL6OCAREL+g+JHJBOzJqz2McZ+h3SEi/1KlMgcWBewQrEtWLSgV5djftK
         7bw1NTmZG1G7ALgvPyDYxJVwRo+BXFBOx6GH9HmT3wraLIZCUWuMT8xEU3iqYhPddXwu
         YOtv376WPuB4uWT+hib39jtQGMkxQnz/tGTUpk9sbR9xV97FgseQCYfL7JL0Dn5XwPeV
         urMN0xnh5AfUc4mQ8JtbH6oB3X9jvCEvee7ZITbeB5rEhhEvHiwPvCw7ebAX5Rvs9QcG
         gO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q+P8Jh7kTsA5bya4Kwslqfb/4BJWoIKG0VmeGG0Dx5s=;
        b=p/aMWVgEB3kYXKceCNi2Zl8KYu4c5Zk2Gu/TSEXYVYkgPwAncdRBHmNeFkmgxhCAgK
         nO/PKVg4hVAMny+Fj4DVv+MsjAflr3CgJ2BimUwvxXHcURW6airSlVHV/gUgEHjPvCBk
         bONx4D0F2bbEQB3SU+CESPERIinKaTKaUlBcq2WQ4ogm6OnVbLm6f1tbsnXRCse9/9t1
         JH6iA06EWGOfGhNxKsUFo7GZGRVVLshITz30ssaSQ2jR9nfW5eeMdhm8tOT8W+1AWlHv
         FFEQI+ZGKHuFo9x4F7R1GzegwMfDx11YS21ev4wqzj66Uv42E94kI+07ejBAOKOodmoc
         2paQ==
X-Gm-Message-State: APjAAAUiTaMLOXUdzQpnAdbH/eZPkltYBwlFlAcQeBFNyVgQlHToio9O
        ROQDa1aziQu7F23/SNPxUCcz8JOZT5TszC6rNfxwAQ==
X-Google-Smtp-Source: APXvYqxTJ6Ia9ssMT5eGTfeY08w9drZGcrPSBwXgalkV3wVW/kdMay2PaYJRt0VxY9/93ZWSKN/nq5+NIW/jvwVI3wA=
X-Received: by 2002:a05:6638:626:: with SMTP id h6mr9546135jar.113.1573032779106;
 Wed, 06 Nov 2019 01:32:59 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Cl=C3=A9ment_VIEL?= <vielclement@gmail.com>
Date:   Wed, 6 Nov 2019 10:32:48 +0100
Message-ID: <CAN1pBYmvcxFoM_zPZYeoUociEJBYHEfMmnspLfSL2=BKiu4Wbg@mail.gmail.com>
Subject: synchronization problem on old version of j1939 stack
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

I am currently using a very old version of the j1939 stack. It was
forked in 2014 and now running on a custom 3.10.17 kernel. We are
experiencing a lot of synchronization problem that cause kernel
panics.
Doing diffs with the mainline version shows that the whole stack has
changed a lot, I noticed, this first mail concerning j1939 on this
mailing list is from 2018.
 My question is very simple. Did synchronization problems were
encountered and corrected before the j1939 entered the mainline ?

Regards

-- 
----
Clement Viel
Tel : +33688431961
-----
