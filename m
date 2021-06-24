Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F443B3456
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhFXRLp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFXRLn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 13:11:43 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83413C0617AE
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 10:09:22 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s19so7100547ilj.1
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=p95plxgcKdT8+TUJCmcKdAyJL6L8C+j3muAeTI6tbvEOMwKUFZvBH22Z3GEGxdnUZH
         d9XkDasjcz/bUj2n1PkWxPPQL/Sxtf1a7ckN43IkWwU4a9v6DYeOi9Tg8DPYHl700hH/
         xlmv54Ir2NUVB8zwaX1UsxTzP5GUW3mdywmszCeflzWKbXzDgkMNhx+qVsi3FklHnD5x
         fSDWvxz3POXOJ/0yZM+F2G99rPMTFJK+bPA5TWYu0VJpvpEjmQwRSgXLB6dx+kXpC0Uz
         JX+JhI0lSB7VkwJTdkbApCrUx6TGzp99N5mAm/d0lil4hmexz93RFAPSpMzmwkjNchKB
         rXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=E1b9V8rTCmLz8Qx6vb1E62Vh2L81LBS2VRNWjxn4N7ETvDhEKIzkYir0eKt6/w9kRV
         75L3vt/feIX3u/Oc+Pv8U/6DI5adOsHDnukPje4jpRHHq4lhiD0LQWmfx61YtV6MgQCo
         D1d2RmT5jyEUN2Av9+5Aiyw8DZHHlin3YH37v3y7HakNvHxbjneHIZHpIepCuEDbeHWJ
         IYgkVr5TqbW7W5Jmvf//VZ4itRyzp+Srvl982jBf6PaCh9bCJyW119eJwlkIHj1pmm44
         XKtUzM3kiWpxI+uPDOuamyAOaBkRQqHAPTm9gCTERq0UF5EZ0Jp7aRtX9oBpk/gRB6Zz
         GeSg==
X-Gm-Message-State: AOAM530vjpbexzkoTM2IBH9ZxNWuvz8vLH5YyqRHPWWvrfwE/GzYfoh5
        696aQCrz8STTLj7hhtvtyoCo3hqDh2nN0pLAbpg=
X-Google-Smtp-Source: ABdhPJzkYUuO368jts0QgMQyJe9SHzg0U698qd8KdfojEfYsXnHtwMfPGxVHmw7fwQ64+IhHRhAEJH5nusdeW4BWzcA=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr4098121ils.255.1624554560853;
 Thu, 24 Jun 2021 10:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3aa:0:0:0:0 with HTTP; Thu, 24 Jun 2021 10:09:20
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
References: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
From:   tuty woolgar <faridaamadoubas@gmail.com>
Date:   Thu, 24 Jun 2021 17:09:20 +0000
Message-ID: <CADB47+607zNBfYFb4bj0nUhuuYgAdwT=G_wJ9-EeV0ESHe56Jg@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
