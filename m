Return-Path: <linux-can+bounces-691-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7EC8D4FBD
	for <lists+linux-can@lfdr.de>; Thu, 30 May 2024 18:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A08F1F21765
	for <lists+linux-can@lfdr.de>; Thu, 30 May 2024 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC8A24B5B;
	Thu, 30 May 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEHiA+h1"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56A24B26;
	Thu, 30 May 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086010; cv=none; b=uEV1PAEe1NqEdUG9UQ6ZLhFpZ+QRDm1ETsJ7aWZY6y6PT/znVOjshCpSyAv/O6RM8IuNKP4p0OmoLtN4ULPhAnkwTImigL4eWzxnUPs2awAmYmqFzjogFG64YvgVwwiyHd1MwxixM0O2sMLiBnzjLCEKXjnhqHs23Zq/iiMkIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086010; c=relaxed/simple;
	bh=QcLwZcN683rIjeN6WtFPy3xKG9bOoTFn+rH1LUbETws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoJZqlEqp6dbcwCxltLZrKX+gM9vRh3ZYkEXO96Y33I5imnKlJLIWzLu+aiCVWqs0GYpeBXuT1VQwxBtFZH1fJhNUFJlhzYLkVn5KVHR7ga5xefZrbtk49Hd23LTWEpSCNhduy8niN/azie8upGDvfvOu9cHTjrpwkt/3dD5DL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEHiA+h1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717086008; x=1748622008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QcLwZcN683rIjeN6WtFPy3xKG9bOoTFn+rH1LUbETws=;
  b=kEHiA+h1buM8wzJybJD62V5pVEInmzWznjmFY8+sK78yWh2QyMbpTkVw
   21EolXKuoLaSz4tvlYmAA5CXvQCUJP1CPFSONneT2TGq6w7iu+OMvHkB2
   zCfj5doiBTZHXNCZIdas1EnH7+oxf9OC5fYiJhLJPWy2ojDu2n2Owraw1
   H0TU0y/nbs/1YJx+qWslbOWHdV9ATIuLBXwclt4fpphABA2iaD0ckskTE
   jOhXkre9iHr8CUYd0fMYN2QURxeQ5J/sTDVK9XIId7tpJ/soW2Ii4CptG
   B7xe6u3tvzdjR5/gxKZWoKxKrq1ifeDbbVE1FH/ehS9LB1TqyZHxtcLa5
   A==;
X-CSE-ConnectionGUID: TokN2rpXShWcsVwA5BG74Q==
X-CSE-MsgGUID: /2vIJM60RtyKxT+4ye4yCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13397356"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="13397356"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 09:20:07 -0700
X-CSE-ConnectionGUID: zPbvAMj+TByFGlipSReLCw==
X-CSE-MsgGUID: 7sQAvfiIStmwMJTz5JZH2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="59038255"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 30 May 2024 09:20:04 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCiVH-000Fgk-1D;
	Thu, 30 May 2024 16:19:51 +0000
Date: Fri, 31 May 2024 00:15:05 +0800
From: kernel test robot <lkp@intel.com>
To: Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] can: m_can: don't enable transceiver when probing
Message-ID: <202405302307.MKjlGruk-lkp@intel.com>
References: <20240530105801.3930087-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530105801.3930087-1-martin@geanix.com>

Hi Martin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkl-can-next/testing]
[also build test WARNING on linus/master v6.10-rc1 next-20240529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Hundeb-ll/can-m_can-don-t-enable-transceiver-when-probing/20240530-185906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
patch link:    https://lore.kernel.org/r/20240530105801.3930087-1-martin%40geanix.com
patch subject: [PATCH v3] can: m_can: don't enable transceiver when probing
config: i386-buildonly-randconfig-003-20240530 (https://download.01.org/0day-ci/archive/20240530/202405302307.MKjlGruk-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240530/202405302307.MKjlGruk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405302307.MKjlGruk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/can/m_can/m_can.c:1725:11: warning: variable 'err' is uninitialized when used here [-Wuninitialized]
    1725 |                         return err;
         |                                ^~~
   drivers/net/can/m_can/m_can.c:1674:24: note: initialize the variable 'err' to silence this warning
    1674 |         int m_can_version, err, niso;
         |                               ^
         |                                = 0
   1 warning generated.


vim +/err +1725 drivers/net/can/m_can/m_can.c

  1670	
  1671	static int m_can_dev_setup(struct m_can_classdev *cdev)
  1672	{
  1673		struct net_device *dev = cdev->net;
  1674		int m_can_version, err, niso;
  1675	
  1676		m_can_version = m_can_check_core_release(cdev);
  1677		/* return if unsupported version */
  1678		if (!m_can_version) {
  1679			dev_err(cdev->dev, "Unsupported version number: %2d",
  1680				m_can_version);
  1681			return -EINVAL;
  1682		}
  1683	
  1684		if (!cdev->is_peripheral)
  1685			netif_napi_add(dev, &cdev->napi, m_can_poll);
  1686	
  1687		/* Shared properties of all M_CAN versions */
  1688		cdev->version = m_can_version;
  1689		cdev->can.do_set_mode = m_can_set_mode;
  1690		cdev->can.do_get_berr_counter = m_can_get_berr_counter;
  1691	
  1692		/* Set M_CAN supported operations */
  1693		cdev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
  1694			CAN_CTRLMODE_LISTENONLY |
  1695			CAN_CTRLMODE_BERR_REPORTING |
  1696			CAN_CTRLMODE_FD |
  1697			CAN_CTRLMODE_ONE_SHOT;
  1698	
  1699		/* Set properties depending on M_CAN version */
  1700		switch (cdev->version) {
  1701		case 30:
  1702			/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
  1703			err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
  1704			if (err)
  1705				return err;
  1706			cdev->can.bittiming_const = &m_can_bittiming_const_30X;
  1707			cdev->can.data_bittiming_const = &m_can_data_bittiming_const_30X;
  1708			break;
  1709		case 31:
  1710			/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
  1711			err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
  1712			if (err)
  1713				return err;
  1714			cdev->can.bittiming_const = &m_can_bittiming_const_31X;
  1715			cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
  1716			break;
  1717		case 32:
  1718		case 33:
  1719			/* Support both MCAN version v3.2.x and v3.3.0 */
  1720			cdev->can.bittiming_const = &m_can_bittiming_const_31X;
  1721			cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
  1722	
  1723			niso = m_can_niso_supported(cdev);
  1724			if (niso < 0)
> 1725				return err;
  1726			if (niso)
  1727				cdev->can.ctrlmode_supported |= CAN_CTRLMODE_FD_NON_ISO;
  1728			break;
  1729		default:
  1730			dev_err(cdev->dev, "Unsupported version number: %2d",
  1731				cdev->version);
  1732			return -EINVAL;
  1733		}
  1734	
  1735		/* Forcing standby mode should be redunant, as the chip should be in
  1736		 * standby after a reset. Write the INIT bit anyways, should the chip
  1737		 * be configured by previous stage.
  1738		 */
  1739		return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
  1740	}
  1741	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

