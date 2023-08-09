Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8477762FB
	for <lists+linux-can@lfdr.de>; Wed,  9 Aug 2023 16:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjHIOtB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Aug 2023 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjHIOtA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Aug 2023 10:49:00 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0367426AA
        for <linux-can@vger.kernel.org>; Wed,  9 Aug 2023 07:48:45 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bc886d1504so6187048a34.0
        for <linux-can@vger.kernel.org>; Wed, 09 Aug 2023 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691592524; x=1692197324;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=qKmv7VIMiE2Ho+02WuyW5S4rA8fbiUe+wtbFDeFsp7ZpR4GH+5ANs08q+NmdheUXLV
         WFSCFdE4ydf5rMIO3gFStqeHp78Bn8P9AeBtCK1uzkoRoMLqtLyqrSxshyWvaiaC+saX
         B1D/TLEXCWDtJLaBXQyfO/BFBZyptu2FiA26FjrtlBJkTnaoin5NVkBDnLxjmZwJl0/+
         WkgEV/dwHAnr6/yogKL4W/ddL2BiRHx77j1+QMQLZKvU++NGDTz+LExNzQ7WEpTaXT++
         74KP47xCfMU7+eoMlee4XIB62UtpYFnbmImzdpZIlta4g2ag1+xlDm7MAIe8OZ3109hP
         gSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691592524; x=1692197324;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=b4moVcBv6RwnzeS6Na2l5OIuHsqd8DJRZN4dG8LLGoMlIF7+hSzdhDgmsJTnusirmC
         80jCfLTFCladI7x3fpZv6WHW6IC1CK24YFd+dSld4Y8dASxFRhT4b6MCuHxiMdHzDqe9
         p2sbLWWM/T5QlBPAepxLwNGJJ8+pHLoPgZVZGLotybkTWRZZdEAaO4yx/o1JSEsUhXMY
         ReEAhAokVYFLH+PMFJhNJ+tzE1p8+RWufW1Pe5daj523vWlPYjMWoSRB71493GEbi9VG
         JSfkHnA17KVQ+8aQgD34jgzShtnz2Wj2hYPfuhczS5vkdSmwUU1azZGLyI//d2CHDOnJ
         dBaQ==
X-Gm-Message-State: AOJu0Yy+HPi4UfhiX+cCDIOwRRIMxdsR221fFBf9WlAAYWLYkhLEDOHL
        lW03N+zLkucdkLaEfBZNFExsXXKA9vKMoIFHy6Q=
X-Google-Smtp-Source: AGHT+IFnMZV/Tepg/pxXNz5F327VvxgIC5AAq4V7oF57jXkkw29n3YX3lFruJAcb/8pvZcuyqRBt09/suL4PouBwbFQ=
X-Received: by 2002:a05:6808:e8d:b0:3a7:53f1:16ac with SMTP id
 k13-20020a0568080e8d00b003a753f116acmr3364392oil.20.1691592502384; Wed, 09
 Aug 2023 07:48:22 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsthereseninna@gmail.com
Received: by 2002:a05:6358:71c3:b0:f1:be9a:c0c5 with HTTP; Wed, 9 Aug 2023
 07:48:20 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Wed, 9 Aug 2023 07:48:20 -0700
X-Google-Sender-Auth: O7I42bblFw4V1Z1d3Ig3xne0ObI
Message-ID: <CAKVHDg846kpmnnkkdAMdnF7=uH8_CQyTkfzxvf0swbgcKOZ+2g@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
