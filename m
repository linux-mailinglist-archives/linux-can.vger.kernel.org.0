Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9624D3E8A3E
	for <lists+linux-can@lfdr.de>; Wed, 11 Aug 2021 08:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhHKGfg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Aug 2021 02:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhHKGfg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Aug 2021 02:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1978C061765;
        Tue, 10 Aug 2021 23:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X/9UKyHOryjlmUGIKGWy+RTCadBtP6oBKSG5ANMcSkQ=; b=pCFgJlYt2edG1XOl4oriihOBVC
        lwMYAOaI31yWH3EzAA40GuhzgXiBVktn9F8/GoCyXmnuUFhNdERc1Xaoyg47ZckMXRDKU1BY9G/8L
        y+xaoayK4hXZ0SKxNi1BJaAFtMlBEJ4u1PcxYS+HosSHOAh3lxqVt3x3g9LC6DxRszVaIDmVuoCAK
        xRGqr+XU6lJ7yIUAobcGadwoNR+uggjv6pc8elArVdaz34mgWgfRNe1CwRriSba1BSr70EwjVROnJ
        yTLFrFqsqRHjXy4I4eXO002WpfdO0GTb/UJ9BZKgUEOBI+R2lTzB4dmDURli1YVMwTOEcrzxB/OX9
        3wE8LYmg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDhp6-00D4x8-4V; Wed, 11 Aug 2021 06:34:50 +0000
Date:   Wed, 11 Aug 2021 07:34:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>, socketcan@esd.eu,
        Stefan M??tje <Stefan.Maetje@esd.eu>
Subject: Re: [PATCH v3] mailmap: update email address of Matthias Fuchs and
 Thomas K??rper
Message-ID: <YRNvhNtdzUA2NZZX@infradead.org>
References: <20210809175843.207864-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809175843.207864-1-mkl@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I do not think that this is proper use of .mailcap, which should
redirect email to person from one address to another.  What you do
is hijack mail to be sent to one person to a set of others.
