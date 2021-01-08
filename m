Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F002EF55D
	for <lists+linux-can@lfdr.de>; Fri,  8 Jan 2021 17:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbhAHQCR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jan 2021 11:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbhAHQCR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jan 2021 11:02:17 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09BCC06129D
        for <linux-can@vger.kernel.org>; Fri,  8 Jan 2021 08:00:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id d14so8757556qkc.13
        for <linux-can@vger.kernel.org>; Fri, 08 Jan 2021 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ik6B+6lkNc+iFrIPLOlH6nyfA0JsJ4cRGzVhof+Ll8w=;
        b=VpA/rpQ5qi0dFR7Mowe5aGCpF9u7a1VmQn5q9ZZuQCrdDN5tZn6sXwU9XTDBXmdfYo
         GHrqoepeF5HsPEyz7s83Q2FgcvfAPgYumhvcRGiBVC2GK+C5XV14Ui++lS3so5pA2/iT
         1rfJS9pZ3rxyDmU9J33KM0ODd0VovMdrCXj4PDHLrX+mNc/gXoaOQ9JB4dQ8+Pi+t3Y5
         owDd0dhEIxx5inTgS9uv9USD9ua3iUgbE7ZeBpPZmm3e8Mr6fY26xd3tbIKjFdXg+Z5e
         HzKpZOj3j3xkWAI+2U0PJ6WCaJvaJp4eQ7JPK2DyyOLy9Is9PPJi0kyYoCvOmtdELPp9
         eESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=ik6B+6lkNc+iFrIPLOlH6nyfA0JsJ4cRGzVhof+Ll8w=;
        b=I+/3TlRplZLdaOd6wsakYDWWLuASmlgFSsYwUrWJZChB0SBYfndV6Q1jvH/Uj6arbp
         M1lkHxGGBVnp+uk/ai0c61zoyloIMjAinmOlNM9yX4aJ9FX47WppNIjY/G6v+JXBlhfv
         ltpCBUCWztDljonQEmAzsP+JAnvEpRjPDbG/MK6X0eomsoplAgdk/bVISAtQsIykdiiz
         DIX6a8/sEFQwgHUPfM9Qsq2M42G272ISXtVnIUuZxybBRw8m+AHxzdf5aUlBaog8vxpL
         pBytJdCBJYzQc49Tv4PuV+awyRWC6FqgNDy7+kvvR2mUCevTgtAVMRwCl1ojeWgO35hT
         22kQ==
X-Gm-Message-State: AOAM532Uamcx8Rzjwf6ssnfsdjECXumitwynOk6Ggkr6gItZy9bVBWwO
        IKWeFjz25PMAmY8nDj7gMdFUekxSFARurXf/8ME=
X-Google-Smtp-Source: ABdhPJy5DcDb2tpoN6hwwNxbrQ4+6iS7cEF5BYexkcUy5+hBuogz8U9cM9vP/oN0NUHGYqGpdQYDJc3bSIrriX19zaw=
X-Received: by 2002:a37:9f14:: with SMTP id i20mr4583418qke.321.1610121655742;
 Fri, 08 Jan 2021 08:00:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:148d:0:0:0:0 with HTTP; Fri, 8 Jan 2021 08:00:55
 -0800 (PST)
Reply-To: camillejackson021@gmail.com
In-Reply-To: <CAGCmbMQupVT-1ZX2--N7Bjf2eW4VuUQ4dE_hzd1qAGQuE_JBEQ@mail.gmail.com>
References: <CAGCmbMQupVT-1ZX2--N7Bjf2eW4VuUQ4dE_hzd1qAGQuE_JBEQ@mail.gmail.com>
From:   camille jackson <adamraouf78@gmail.com>
Date:   Fri, 8 Jan 2021 16:00:55 +0000
Message-ID: <CAGCmbMR9p4PyoggcTsQ1z8w+PCmEh+pd463ifnbWZyKw1o3FtQ@mail.gmail.com>
Subject: =?UTF-8?B?0JfQtNGA0LDQstGB0YLQstGD0LnRgtC1LA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

0J/RgNC40LLQtdGC0YHRgtCy0YPRjiDRgtC10LHRjywg0LzQvtC5INC00YDRg9CzLCDQvdCw0LTQ
tdGO0YHRjCwg0YLRiyDQsiDQv9C+0YDRj9C00LrQtSwg0L/QvtC20LDQu9GD0LnRgdGC0LAsINC+
0YLQstC10YLRjCDQvNC90LUNCtCx0LvQsNCz0L7QtNCw0YDRjywNCg==
