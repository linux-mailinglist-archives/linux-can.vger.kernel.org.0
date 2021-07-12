Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4776E3C647C
	for <lists+linux-can@lfdr.de>; Mon, 12 Jul 2021 22:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhGLUEU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Jul 2021 16:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhGLUEU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Jul 2021 16:04:20 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A70FC0613E9
        for <linux-can@vger.kernel.org>; Mon, 12 Jul 2021 13:01:30 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 9so19239375qkf.3
        for <linux-can@vger.kernel.org>; Mon, 12 Jul 2021 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=a2dsXs+UojnlPR+t9GnHd2UZfhfGGGFvH8eZJQUfhIg=;
        b=q5e/M/tcYJli1VlUf2j6v1yWKre+9bhtaCsXHJK9vNRc+O4SZfShrPahsSFofgoRP/
         xGvHhlay1E0neyYiIQ8RKYI2ZsIzl4QWFAgoZBKVgzqLuEeWh8FfW/anq/nWD0xbxEBh
         yVu8yz4ND03GlRoBefgjKTwswxqDoHuIxcEnlEE5p/cjZRK0R7PskacYjbhqPa3dKLxr
         f5TaDTHOanTNAXunB3ygv9MjGoipGUetuJ4OkCQ2MlgSBRSUj3Gtjl0qw5g/pWGc/+En
         dU4eND9pxK6WAQLPaKplA142+lkv5Zkw9Q/LxxT3dbhA9BdaTGkk+4K2o6gh5zj8d4Dt
         Pl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=a2dsXs+UojnlPR+t9GnHd2UZfhfGGGFvH8eZJQUfhIg=;
        b=pBY2hTQlQIaaZAJW1rlL39idH+r2/6E9GR8syxbRuRcZ+7j+xMrwN4MuSvRFbBZEFM
         zQXGcPvWVRlTCw2djYEEs4MDxJcuA05Xk/Oedqa7v4Y5dppm5GXm76cTnf+P3ALGUT3L
         CQe2gvWO/ZV6NUu1zZqe3lgtSBfNwlKnqyEHObGfDG44SDVzEaS3ZZsBCQroczJpLGfD
         asMeZktgZ9EI3a0+2iPMbMqu0bGnRx2XFklb687+KAJjUBvinD6tnikJmwMTyukubmli
         Msi+u06RQwrYaFzOpiNyya3ARnwute2qNKDSoWCIU0wSZ9oHD9cn1/4Kao4Io+S3gUhc
         rGzQ==
X-Gm-Message-State: AOAM531j7fv6OYc81+GYBNjEkkOVajU5P611L4tp2y73tMxh6p0cUOPR
        vB3CW6LB55Rw18ZGCFpYzX4=
X-Google-Smtp-Source: ABdhPJwWvVTeBeQ/M+f5M7qzfZaBFaCYa/wtFjkvR3sm0zJB0LAJWjUA1opTBEfhlD777mm1+i76IA==
X-Received: by 2002:a37:a013:: with SMTP id j19mr417567qke.77.1626120089460;
        Mon, 12 Jul 2021 13:01:29 -0700 (PDT)
Received: from DTJQUESENBERRY ([2001:468:c80:a202:1de7:4e01:590a:fc56])
        by smtp.gmail.com with ESMTPSA id 197sm1672197qkn.64.2021.07.12.13.01.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jul 2021 13:01:28 -0700 (PDT)
From:   "Joshua Quesenberry" <engnfrc@gmail.com>
To:     "'Patrick Menschel'" <menschel.p@posteo.de>,
        "'Marc Kleine-Budde'" <mkl@pengutronix.de>
Cc:     <kernel@pengutronix.de>, <linux-can@vger.kernel.org>,
        <engnfrc@gmail.com>
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com> <20210622212818.enfx5fzgghfxfznb@pengutronix.de> <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com> <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de> <029101d76855$fa5ac300$ef104900$@gmail.com> <20210625065626.b7afwhptoyoxoblx@pengutronix.de> <20210625121648.hg4hihfmddss7ptu@pengutronix.de> <020f01d769da$9fac86b0$df059410$@gmail.com> <022d01d769e2$e623cbf0$b26b63d0$@gmail.com> <20210702093110.vzfjk4dgovrrs4mj@pengutronix.de> <CAMGHUo=NK0Q=4y8Wgp3Mo+G8CuUcK8gLhxBH6Z1to8PZMZRr3w@mail.gmail.com> <006601d77296$68e41d40$3aac57c0$@gmail.com> <02be01d7774f$b9c29da0$2d47d8e0$@gmail.com> <d68ced7f-a407-da41-520f-d12d8161f027@posteo.de>
In-Reply-To: <d68ced7f-a407-da41-520f-d12d8161f027@posteo.de>
Subject: RE: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
Date:   Mon, 12 Jul 2021 16:01:28 -0400
Message-ID: <02dd01d77758$b3c79d70$1b56d850$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKkU7o+qbTtuE7WZsCEE+zhLGrysQHOwZAXAgLTME4A15gpjQI9UoC3AfsMaV4CTizomAGzk0WoAZKSgAIBs/x7BAFwQIEbAfLOJN0BcZL7BAI6B91qqOxFrNA=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks for the suggestion Patrick! I will do that shortly.

Josh Q

-----Original Message-----
From: Patrick Menschel <menschel.p@posteo.de>=20
Sent: Monday, July 12, 2021 3:57 PM
To: Joshua Quesenberry <engnfrc@gmail.com>; 'Marc Kleine-Budde' =
<mkl@pengutronix.de>
Cc: kernel@pengutronix.de; linux-can@vger.kernel.org
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y

Am 12.07.21 um 20:57 schrieb Joshua Quesenberry:
> Any thoughts on my recent findings? So far the raspberrypi.org forums =
haven't proved fruitful, not sure if there's another more appropriate =
place I should take this conversation now that the issue doesn't seem to =
be relating to the CAN drivers themselves, but underlying subsystems =
conflicting.


Technically you could open an issue on
https://github.com/raspberrypi/linux

This is usually the straight forward solution to get in touch with the =
platform experts.

Cheers,
Patrick

