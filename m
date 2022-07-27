Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0AE582872
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 16:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiG0OUk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 10:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiG0OUj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 10:20:39 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3336B84A
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 07:20:37 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e132so16035367pgc.5
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=0/L4B2GGJDQUaVM7EyV5YNuD8zoXE6v6ubSCy9jYTOQ=;
        b=WU5Nb1rLpWoyRucTpwxdvgk4fgv69jGdXhS29NsblpudL77sKrLnZz5JnInJj4qH/C
         5fQycMZXLGHdPte34aa6q53ORp99zqH+FftY3OGxGVBgJS/T3dY0dgxS0RDlsWSd5o9m
         k5re+q12UPeVGbERYDNGnCD9bW9T6Rnkx8Vyv+KhRYj8Oiq89Cm5RjsuZNrxNST1Nr2D
         iJ6g7otMbr7pQ3Umxr9dDIP6oJZpniyWnuVG++kIowCcxuiAJb2lmyR8rgTp+Z0eFrdk
         B9kB2LnGjfGZwzY9BbY2HT5n7D3sIni3Imxt5H4CySl7FxdYyrvl1ilAsWOEJ6A6gjc3
         LGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=0/L4B2GGJDQUaVM7EyV5YNuD8zoXE6v6ubSCy9jYTOQ=;
        b=JOWv2xpjsgu5EG2LUwTauwkPmMpbqN9/P8aZE8FaZ6g6IOv3ncXgckqRqAjZnlMv30
         dIjbMkTcts1ueO6OzIPQt4yaBmP71wJfBnsClX3UrMytcq/yg7jNFgPaUTYMxmTQ6vHl
         ssNorEtgX5R91gkT1HE/9ydYpbvO15lky06EEkNgPb6xJfEFTF7zIzID0kOlh/JD8+NV
         1mKV5CVN4BscnGucAprxivsmafp6HrCMlEPBXF1RD7XzvAaUA4MYAPhIN5N1fSQ8vwfv
         7/2gHaSmZparZkbQ8SWtueY7n3wLTmnnO9HerPFX1QgNAPlQ5ui+ylD0xTae0IQkqyK/
         VyeA==
X-Gm-Message-State: AJIora+KnHxZlP775kNBaCA3Rov91gPDLDBb8q55H6dKdvy2oAFqA9vU
        br5cyAPGIQqxgRBUNt4OkHHFzaViztlZppBi13Q=
X-Google-Smtp-Source: AGRyM1uKimEl/SfZns8BuDKVhO7qa6VE/qmjavXCQh//l8K4E4XKcxBFpEXA+/qRFRLLcqc3D1agyDP0Cyinx0ZmnVw=
X-Received: by 2002:a63:d614:0:b0:411:acdb:5c55 with SMTP id
 q20-20020a63d614000000b00411acdb5c55mr18444714pgg.245.1658931637571; Wed, 27
 Jul 2022 07:20:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8e83:b0:29e:d3b1:1e66 with HTTP; Wed, 27 Jul 2022
 07:20:37 -0700 (PDT)
Reply-To: sgtmanthey12@gmail.com
From:   Kayla Manthey <pelajitomdjolo@gmail.com>
Date:   Wed, 27 Jul 2022 14:20:37 +0000
Message-ID: <CALuaCmJF6cTEtWn3QMfSvvo+hyjsjETwi6ysCgvz9OLsE+sfNw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

-- 
Hola,
Por favor, recibe mis mensajes anteriores.
