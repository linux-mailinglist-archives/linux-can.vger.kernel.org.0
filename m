Return-Path: <linux-can+bounces-592-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A1E8BE930
	for <lists+linux-can@lfdr.de>; Tue,  7 May 2024 18:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3653A1C23EF2
	for <lists+linux-can@lfdr.de>; Tue,  7 May 2024 16:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66950A80;
	Tue,  7 May 2024 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZ9ZZVQi"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308F78281;
	Tue,  7 May 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099497; cv=none; b=YnaGrrjKCt67rVjNFUmKqKlaH1rD8thulS0ZF2XLQKkxGwxsqIsOYRb5qS4JLZaDueGJEdTIRfA4VolFEXubdWc0bxcipEcch+JO8/7xGz0TfFBi6D0p9xLouPwVkdjgtxJNGEnZsdf5zdEqH4TG9gp+eIU/L8KB+5AxMxD0dWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099497; c=relaxed/simple;
	bh=FbE34TinZeUuwBtTea/BQyjugfoOJ21Vf987cKYCLtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFHfgM1NQzYjidEzOzsRtm4XAvgWhdhRjEr5k7ZV/aOwc6JQ/p6bDLlxiK/FLiFt2qnjU7jIxU1JxKH9OwqkK0+ZpHl5fOqjRDVlJ0iE7CupcEUgivPiV6X5O3NCIV3AZtU4UhzCI7Zc3SILzh/qMVHUkfOaTttgCUBkihgFXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZ9ZZVQi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715099495; x=1746635495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FbE34TinZeUuwBtTea/BQyjugfoOJ21Vf987cKYCLtA=;
  b=HZ9ZZVQiVhCf3HKxg/Wjb6mJMtCb7GZ5nnzv3rMJnD3fRFNo9QnS9qUm
   oNV18h8y5SkJdbVs0XY24dsbZ9fq0fmdWEj7xfnsuoR2rt0wpZ1QXLnJs
   jTsJVY9EEsK7lRPk5CmEhKl4mKdJxjCu4Eq27GYtcnsVJ0P5WWZ90aAnD
   7HapUCudd8OuX+VViIhDVP9A9wZJyLdZuk+4gLlkFtSzTxMNDlVQUuV2J
   ARAp9SN1q6suavob3qi08e0ATZqE04/y8Arg7wzzBtxXmzJERkVulNX+p
   BQcqAPrJoGNTiAy0LboCZTJ/ci4rd1fCaX9EYGrBs7QxZoofpBOWqDO19
   w==;
X-CSE-ConnectionGUID: MWVwjMfnRUy8yEkcaYkmZQ==
X-CSE-MsgGUID: NZ1EqG9HSnujQ8MhMcFcaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11033868"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="11033868"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 09:31:27 -0700
X-CSE-ConnectionGUID: WIPO6z9+SKmbaC+lheVRZw==
X-CSE-MsgGUID: 6damU1wNSjGxMlqr6GlA8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="33260963"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 09:31:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s4Nir-000000056m0-3iZK;
	Tue, 07 May 2024 19:31:21 +0300
Date: Tue, 7 May 2024 19:31:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] can: mcp251x: Fix up includes
Message-ID: <ZjpXWVVG105w_lSg@smile.fi.intel.com>
References: <20240412173332.186685-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412173332.186685-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 08:33:32PM +0300, Andy Shevchenko wrote:
> This driver is including the legacy GPIO header <linux/gpio.h>
> but the only thing it is using from that header is the wrong
> define for GPIOF_DIR_OUT.
> 
> Fix it up by using GPIO_LINE_DIRECTION_* macros respectively.

Marc, any comments on this?

-- 
With Best Regards,
Andy Shevchenko



